module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum0;
    wire [15:0] sum1;
    wire [15:0] sum2;
    wire cout0;
    
    add16 inst0( .a(a[ 15:0]), .b(b[ 15:0]), .cin('b0), .sum(sum0), .cout(cout0));
    add16 inst1( .a(a[31:16]), .b(b[31:16]), .cin('b0), .sum(sum1));
    add16 inst2( .a(a[31:16]), .b(b[31:16]), .cin('b1), .sum(sum2));

    assign sum = {{cout0? sum2 : sum1} ,sum0};
endmodule