module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire c[2:0];
    full_adder inst0(.a(x[0]), .b(y[0]), .cin('0), .cout(c[0]),.sum(sum[0]));
    full_adder inst1(.a(x[1]), .b(y[1]), .cin(c[0]), .cout(c[1]),.sum(sum[1]));
    full_adder inst2(.a(x[2]), .b(y[2]), .cin(c[1]), .cout(c[2]),.sum(sum[2]));
    full_adder inst3(.a(x[3]), .b(y[3]), .cin(c[2]), .cout(sum[4]),.sum(sum[3]));
endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum );
    // You can make a full adder using 2 half adders
    assign sum = cin ^ (a ^ b);
    assign cout = (a & b) | (cin & (a ^ b));    
endmodule