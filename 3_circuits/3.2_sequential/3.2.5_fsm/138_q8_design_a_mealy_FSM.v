module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    //
    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t state, next_state;
    
    // Register logic
    always @(posedge clk, negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end
    
    // State transition logic
    always_comb begin
        next_state = state;
        z = 1'b0;
        case (state)
            S0: begin
                next_state = x? S1: S0;
            end
            S1: begin
                next_state = x? S1: S2;
            end
            S2: begin
                next_state = x? S1: S0;
                z = x; // Mealy: Outputs depend on inputs
            end
        endcase
    end // always_comb
endmodule
