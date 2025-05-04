module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum0;
    wire [15:0] sum1;
    wire cout0;
    
    add16 inst0( .a(a[15:0]), .b(b[15:0]), .cin('b0), .sum(sum0), .cout(cout0));
    add16 inst1( .a(a[31:16]), .b(b[31:16]), .cin(cout0), .sum(sum1));
    
    assign sum = {sum1, sum0};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum = a ^ b ^ cin;
    assign cout = a & b | a & cin | b & cin;
endmodule
