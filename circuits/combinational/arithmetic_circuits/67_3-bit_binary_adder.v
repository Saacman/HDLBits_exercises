module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    full_adder int0(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));
    full_adder int1(.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
    full_adder int2(.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));
endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum );
    // You can make a full adder using 2 half adders
    assign sum = cin ^ (a ^ b);
    assign cout = (a & b) | (cin & (a ^ b));    
endmodule
