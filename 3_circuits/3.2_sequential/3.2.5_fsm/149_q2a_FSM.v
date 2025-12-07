module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    // State codes
    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t state, next_state;
    
    // State registers
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    // Comb logic, decide next state
    always_comb begin
        next_state = state; // Preserve current state
        case (state)
            A: next_state = r[1]? B: (r[2]? C: (r[3]? D: A));
            B: next_state = r[1]? B: A;
            C: next_state = r[2]? C: A;
            D: next_state = r[3]? D: A;
        endcase
    end
    
    // Output logic
    assign g = {(state == D), (state == C), (state == B)};
endmodule