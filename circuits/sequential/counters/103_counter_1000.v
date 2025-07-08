module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0] q [2:0];
    bcdcount counter0 (.clk(clk),
                       .reset(reset),
                       .enable(c_enable[0]),
                       .Q(q[0])
                      );
    bcdcount counter1 (.clk(clk),
                       .reset(reset),
                       .enable(c_enable[1]),
                       .Q(q[1])
                      );
    bcdcount counter2 (.clk(clk),
                       .reset(reset),
                       .enable(c_enable[2]),
                       .Q(q[2])
                      );
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = q[0] == 4'd9;
    assign c_enable[2] = q[1] == 4'd9 && q[0] == 4'd9;
    assign OneHertz = q[2] == 4'd9 && c_enable[2];
endmodule
