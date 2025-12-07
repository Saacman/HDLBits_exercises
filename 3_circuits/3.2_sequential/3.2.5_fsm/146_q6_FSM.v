module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    typedef enum logic [2:0] {A, B, C, D, E, F} state_t;
    state_t state, next_state;
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Combinational logic
    always_comb begin
        next_state = state; // preserve state
        case (state)
            A: next_state = w? A: B;
            B: next_state = w? D: C;
            C: next_state = w? D: E;
            D: next_state = w? A: F;
            E: next_state = w? D: E;
            F: next_state = w? D: C;
        endcase
    end
    
    // Output logic
    assign z = (state == E | state == F);
endmodule
