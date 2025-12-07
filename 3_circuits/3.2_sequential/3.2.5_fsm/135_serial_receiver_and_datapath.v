module top_module(
    input  clk,
    input  in,
    input  reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output           done
);
    // 4-state FSM with counter-based data collection
    typedef enum logic [1:0] {IDLE, DATA, STOP, ERROR} state_t;
    state_t state, next_state;

    reg [7:0] data;
    reg [2:0] counter;  // 0..7

    // Next-state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE : next_state = in? IDLE: DATA;          // start bit (0)
            DATA : next_state = (counter == 3'd7)? STOP: DATA;        // after 8th bit
            STOP : next_state = in ? IDLE : ERROR;                // stop bit must be 1
            ERROR: next_state = in? IDLE: ERROR;          // wait for idle high
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else       state <= next_state;
    end

    // Bit counter: reset on entry to DATA; increment only while staying in DATA
    always @(posedge clk) begin
        if (reset) begin
            counter <= 3'd0;
        end else if (state != DATA && next_state == DATA) begin
            counter <= 3'd0;                          // entering DATA
        end else if (state == DATA && next_state == DATA) begin
            counter <= counter + 3'd1;                // bits 0..6; when 7 -> STOP next
        end
    end

    // Data capture and byte output
    always @(posedge clk) begin
        if (state == DATA) begin
            data[counter] <= in;                      // last bit captured when counter==7
        end
        done<=1'b0;
        if (state == STOP && next_state == IDLE) begin
            out_byte <= data;                         // only on valid stop bit
            done<= 1'b1;
        end
    end

endmodule
