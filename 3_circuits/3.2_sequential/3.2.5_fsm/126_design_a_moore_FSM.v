module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);
    parameter EMPTY=0, LOW_NOM=1, HALF_NOM=2, FULL=3, HALF_SUP=4, LOW_SUP=5;
    reg [3:1] state, next_state;
    
    // decide next state
    always @(*) begin
        next_state = EMPTY;
        case(state)
            EMPTY:
                next_state = s[1] ? LOW_NOM: EMPTY;
            LOW_NOM:
                next_state = s[2]? HALF_NOM: (s[1]? LOW_NOM: EMPTY);
            HALF_NOM:
                next_state = s[3]? FULL: (s[2]? HALF_NOM: LOW_SUP);
            FULL:
                next_state = s[3]? FULL: HALF_SUP;
            HALF_SUP:
                next_state = s[3]? FULL: (s[2]? HALF_SUP: LOW_SUP);
            LOW_SUP:
                next_state = s[2]? HALF_NOM: (s[1]? LOW_SUP: EMPTY);
        endcase
    end
    
    // state transitions & reset
    always @(posedge clk) begin
        if (reset)
            state <= EMPTY;
        else
            state <= next_state;
    end
    
    //control outputs
    always @(*) begin
        case(state)
            EMPTY:    {fr3, fr2, fr1, dfr} = 4'b1111;
            LOW_NOM:  {fr3, fr2, fr1, dfr} = 4'b0110;
            HALF_NOM: {fr3, fr2, fr1, dfr} = 4'b0010;
            FULL:     {fr3, fr2, fr1, dfr} = 4'b0000;
            HALF_SUP: {fr3, fr2, fr1, dfr} = 4'b0011;
            LOW_SUP:  {fr3, fr2, fr1, dfr} = 4'b0111;
        endcase
    end
    

endmodule
