module top_module (
    input a, b, c, d, e,
    output [24:0] out );//
    wire [24:0] vector0;
    wire [24:0] vector1;
    
    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    assign vector0 = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};
    assign vector1 = {5{a,b,c,d,e}};
    assign out = ~{vector0} ^ {vector1};

endmodule