module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    typedef enum logic [2:0] {A1, A2, A3, A4, OFF} state_t;
    state_t state, next_state;
    
    always @(posedge clk) begin
        if (reset)
            state <= A1;
        else
            state <= next_state;
    end
    
    always_comb begin
        next_state  = A1;
        case (state)
            A1: next_state = A2;
            A2: next_state = A3;
            A3: next_state = A4;
            A4: next_state = OFF;
            OFF: next_state = OFF;
        endcase
    end
    assign shift_ena = (state == A1 | state == A2 | state == A3 | state == A4);
endmodule
