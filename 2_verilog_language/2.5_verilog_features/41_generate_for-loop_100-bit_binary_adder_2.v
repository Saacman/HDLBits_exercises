module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    
    generate
        add1 addr0(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout[0]));
        genvar i;
        for(i = 1; i < $bits(cout); i++) begin: addr_gen
            add1 addr(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .sum(sum[i]), .cout(cout[i]));
        end
    endgenerate
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum = a ^ b ^ cin;
    assign cout = a & b | a & cin | b & cin;
endmodule