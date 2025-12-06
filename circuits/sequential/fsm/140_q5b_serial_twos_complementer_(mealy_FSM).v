module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    parameter A = 0, B = 1;
    logic [1:0] next_state, state;
    
    always_comb begin
        next_state[A] = (state[A] & ~x & ~z) ;
        next_state[B] = (state[A] & x & z) | (state[B] & x & ~z) | (state[B] & ~x & z);
        z = (state[A] & x) | (state[B] & ~x);
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state = 2'b01;
        else
            state = next_state;
    end

endmodule
