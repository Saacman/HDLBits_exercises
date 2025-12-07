module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0] inter0, inter1;
    assign inter0 = a < b? a: b;
    assign inter1 = c < d? c: d;
    assign min = inter0 < inter1? inter0: inter1;

endmodule