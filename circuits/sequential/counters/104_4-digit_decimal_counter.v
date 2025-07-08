module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    decade_counter counter0 (.clk(clk),
                             .reset(reset),
                             .enable(1'b1),
                             .q(q[3:0])
                            );
    decade_counter counter1 (.clk(clk),
                             .reset(reset),
                             .enable(ena[1]),
                             .q(q[7:4])
                        );
    decade_counter counter2 (.clk(clk),
                             .reset(reset),
                             .enable(ena[2]),
                             .q(q[11:8])
                        );
    decade_counter counter3 (.clk(clk),
                             .reset(reset),
                             .enable(ena[3]),
                             .q(q[15:12])
                        );
    assign ena = {q[11:8] == 9 && q[7:4] == 9 && q[3:0] == 9,
                  q[7:4] == 9 && q[3:0] == 9,
                  q[3:0] == 9
                 };
endmodule

module decade_counter (
    input clk,
    input reset,
    input enable,
    output [3:0] q);
    
    always @(posedge clk)begin
        if(reset)
            q <= 4'b0;
        else if (enable) begin
            if (q < 9)
                q <= q+1'b1;
            else
                q <= 1'b0;
        end
    end
endmodule
