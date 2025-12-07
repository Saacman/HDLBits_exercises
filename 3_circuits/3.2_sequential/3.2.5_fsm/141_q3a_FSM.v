module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 1'd0, B = 1'd1;
    logic state, next_state;
    logic [1:0] cycle_counter;
    logic [1:0] w_counter;
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Decide next state
    always_comb begin
        next_state = state;
        if (state == A && s)
            next_state = B;
    end
            
    // Counters 
    always @(posedge clk) begin
        if (reset || state == A) begin
            w_counter <= 2'd0;
            cycle_counter <= 2'd0;
        end
        else if (state == B) begin
            if (cycle_counter == 3) begin
                w_counter <= w;
                cycle_counter <= 2'd1;
            end else begin
                w_counter <= w_counter + w;
                cycle_counter <= cycle_counter + 2'd1;
            end
        end
    end
    
    
    assign  z = (w_counter == 2 ) && (cycle_counter == 3);
          

endmodule
