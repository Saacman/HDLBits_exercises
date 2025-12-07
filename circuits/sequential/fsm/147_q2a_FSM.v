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
            A: next_state = w? B: A;
            B: next_state = w? C: D;
            C: next_state = w? E: D;
            D: next_state = w? F: A;
            E: next_state = w? E: D;
            F: next_state = w? C: D;
        endcase
    end
    
    // Output logic
    assign z = (state == E | state == F);
endmodule
