module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    wire [7:0] Q;
    always @(posedge clk) begin
        Q <= in;
        pedge <= in & ~Q;
    end
endmodule
