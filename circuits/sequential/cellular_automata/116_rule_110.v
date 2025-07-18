module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q );
    wire [511:0] left =  {q[510:0], 1'b0};
    wire [511:0] right = {1'b0, q[511:1]};
    always @(posedge clk) begin
        if(load)
            q <= data;
        else begin
            // q <=( q | left ) & (~right | ~q | ~left);
            q <= (q | left) & ~(right & q & left);
        end
    end
endmodule
