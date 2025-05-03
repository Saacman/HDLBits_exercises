module top_module ( input clk, input d, output q );
    wire q0,q1;
    my_dff inst0( .clk(clk), .d(d), .q(q0) );
    my_dff inst1( .clk(clk), .d(q0), .q(q1) );
    my_dff inst2( .clk(clk), .d(q1), .q(q) );
endmodule
