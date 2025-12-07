module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    
    // New: Add parity checking.
    // 4-state FSM with counter-based data collection
    typedef enum logic [1:0] {IDLE, DATA, STOP, ERROR} state_t;
    state_t state, next_state;

    logic [7:0] data;
    logic [3:0] counter;  // 0..8 (9 bits)
    logic odd;
    logic parity_reset;

    parity p_check(clk, parity_reset, in, odd);
    
    // Next-state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (!in)
                    next_state = DATA; // start bit (0)
            end
            DATA: begin
                if (counter == 4'd8)
                    next_state = STOP;
            end
            STOP: begin
                if (in)
                    next_state = IDLE; // stop bit must be 1
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in)
                    next_state = IDLE; // wait for idle high
            end
        endcase 
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Bit counter: reset on entry to DATA; increment only while staying in DATA
    always @(posedge clk) begin
        if (reset) begin
            counter <= 4'd0;
        end else if (state != DATA && next_state == DATA) begin
            counter <= 4'd0;                          // entering DATA
        end else if (state == DATA) begin
            counter <= counter + 4'd1;                // bits 0..6; when 7 -> STOP next
        end
    end

    // Data capture and byte output
    always @(posedge clk) begin
        done<=1'b0;
        if (state == DATA && counter < 8) begin
            data[counter] <= in;                      // last bit captured when counter==7
        end
        if (state == STOP && next_state == IDLE) begin
            if (odd) begin
                out_byte <= data;                         // only on valid stop bit
                done<= 1'b1;
            end
        end
    end
    
    // Parity reset
    assign parity_reset = state != DATA && next_state == DATA;

endmodule
