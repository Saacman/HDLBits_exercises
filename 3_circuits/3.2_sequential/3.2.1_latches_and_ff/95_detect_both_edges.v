module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    wire [7:0] Q;
    always @(posedge clk) begin
        Q <= in;
        anyedge <= (~in & Q) | (in & ~Q);
    end
endmodule
