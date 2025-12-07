module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    typedef enum logic [3:0] {A, B, C, D, E ,G1, G2, G_PERM, G_ZERO} state_t;
    state_t state, next_state;
    
    always @(posedge clk) begin
        if (!resetn)
            state = A;
        else
            state = next_state;
    end
    
    always_comb begin
        next_state = state;
        case(state)
            A: next_state = B;
            B: next_state = C; //f=1
            // Check x to recognize 101
            C: next_state = x? D: C; // "1"
            D: next_state = x? D: E; // "10"
            E: next_state = x? G1: C; // "101"
            // Assert g and decide final value
            G1: next_state = y? G_PERM: G2; // g = 1
            G2: next_state = y? G_PERM: G_ZERO; // g = 1
            G_PERM: next_state = G_PERM; // g = 1 permanent
            G_ZERO: next_state = G_ZERO; // g = 0 permanent
        endcase
    end
    
    // outputs
    assign f = (state == B);
    assign g = (state == G1) | (state == G2) | (state == G_PERM);
       
endmodule
