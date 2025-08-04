module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    parameter B1=0, B2=1, B3=2, DONE=3;
    reg [1:0] state, next_state;
    // State transition logic (combinational)
    always @(*) begin
        next_state=B1;
        case(state)
            2'b00: next_state = in[3]? B2: B1;
            2'b01: next_state = B3;
            2'b10: next_state = DONE;
            2'b11: next_state = in[3]? B2: B1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) state<=B1;
        else state<=next_state;
    end
 
    // Output logic
    assign done = (state == DONE);
    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if (reset) out_bytes = 24'b0;
        else begin
            case(state)
                2'b00: out_bytes[23:16] <= in;
                2'b01: out_bytes[15:8] <= in;
                2'b10: out_bytes[7:0] <= in;
                2'b11: out_bytes[23:16] <= in;
            endcase
        end
    end
endmodule
