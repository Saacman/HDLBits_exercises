module top_module( 
    input a, b, cin,
    output cout, sum );
    // You can make a full adder using 2 half adders
    assign sum = cin ^ (a ^ b);
    assign cout = (a & b) | (cin & (a ^ b));
    
    
endmodule
