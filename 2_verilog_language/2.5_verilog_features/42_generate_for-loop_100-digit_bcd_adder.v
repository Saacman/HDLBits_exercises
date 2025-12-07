module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [99:0] cout_l;
    generate
        
        bcd_fadd addr0(
            .a(a[3:0]),
            .b(b[3:0]),
            .cin(cin),
            .cout(cout_l[0]),
            .sum(sum[3:0]));
        genvar i;
        for(i = 1; i < 100; i++) begin: bcd_gen
            bcd_fadd addr(
                .a(a[i*4 + 3:i*4]),
                .b(b[i*4 + 3:i*4]),
                .cin(cout_l[i-1]),
                .cout(cout_l[i]),
                .sum(sum[i*4 + 3:i*4]));
        end
    endgenerate
    assign cout = cout_l[99];
endmodule
