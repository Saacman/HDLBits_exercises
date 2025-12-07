module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    typedef enum logic [2:0] {A, B, C, D, E} state_t;
    state_t state, next_state;
    
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
        case (state)
            A: next_state = data? B: A;
            B: next_state = data? C: A;
            C: next_state = data? C: D;
            D: next_state = data? E: A;
            E: next_state = E;
        endcase
    end
    
    // Outputs
    assign start_shifting = (state == E);

endmodule
