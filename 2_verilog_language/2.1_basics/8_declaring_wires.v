`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );
    
    wire ab;
    wire cd;

    assign ab = a & b;
    assign cd = c & d;
    assign out = ab | cd;
    assign out_n = ~out;
endmodule