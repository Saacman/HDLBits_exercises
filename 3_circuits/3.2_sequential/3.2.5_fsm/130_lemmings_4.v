module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    
    parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3, DIG_L=4, DIG_R=5, SPLAT=6;
    reg [3:0] state, next_state;
    int fall_counter;
    reg aaah_d;

    always @(*) begin
        next_state = state;
        case (state)
            LEFT:
                next_state = ground? (dig? DIG_L: (bump_left? RIGHT: LEFT)): FALL_L;
            FALL_L:
                next_state = ground? (fall_counter < 20? LEFT: SPLAT): FALL_L;
            RIGHT:
                next_state = ground? (dig? DIG_R: (bump_right? LEFT: RIGHT)): FALL_R;
            FALL_R:
                next_state = ground? (fall_counter < 20? RIGHT: SPLAT): FALL_R;
            DIG_L:
                next_state = ground? DIG_L: FALL_L;
            DIG_R:
                next_state = ground? DIG_R: FALL_R;
            SPLAT:
                next_state = SPLAT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= LEFT;
        else begin 
            state <= next_state;
        end
    end
    
    //counter
    always @(posedge clk)begin
        if(aaah)
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_R || state == FALL_L);
    assign digging = (state == DIG_R || state == DIG_L);
endmodule