module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    typedef enum logic [1:0] {Q0, Q1, Q2} state_t;
    state_t state, next_state;
    
    // State register
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= Q0;
        else
            state <= next_state;
    end
    
    // Combinational logic: Decide next state
    always_comb begin
        next_state = state;
        z = 1'b0;
        case (state)
            Q0: begin
                next_state = x ? Q1: Q0;
                z = 1'b0;
            end
            Q1: begin
                next_state = x ? Q2: Q1;
                z = 1'b1;
            end
            Q2: begin
                next_state = x ? Q2: Q1;
                z = 1'b0;
            end
        endcase
    end
endmodule
