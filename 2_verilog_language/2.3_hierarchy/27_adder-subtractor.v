module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b_sub;
    wire cout0;
    // assign b_sub = b ^ {32{sub}};
    assign b_sub = sub? ~b : b;
    add16 inst0( .a(a[ 15:0]), .b(b_sub[ 15:0]), .cin(sub), .sum(sum[15:0]), .cout(cout0));
    add16 inst1( .a(a[31:16]), .b(b_sub[31:16]), .cin(cout0), .sum(sum[31:16]));
endmodule