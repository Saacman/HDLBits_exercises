module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    typedef enum logic [3:0] {NONE, ONE, TWO, THREE, FOUR, FIVE, SIX, ERROR, DISCARD, FLAG} state_t;
    state_t state, next_state;
    
    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            NONE:
                if (in) next_state = ONE;
            ONE:
                next_state = in? TWO: NONE;
            TWO:
                next_state = in? THREE: NONE;
            THREE:
                next_state = in? FOUR: NONE;
            FOUR:
                next_state = in? FIVE: NONE;
            FIVE:
                next_state = in? SIX: DISCARD;
            SIX:
                next_state = in? ERROR: FLAG;
            ERROR:
                if (!in) next_state = NONE;
            DISCARD:
                next_state = in? ONE: NONE;
            FLAG:
                next_state = in? ONE: NONE;
        endcase
    end
    
    // State Register
    always @(posedge clk) begin
        if (reset)
            state <= NONE;
        else
            state <= next_state;
    end

    // Outputs
    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);
endmodule
