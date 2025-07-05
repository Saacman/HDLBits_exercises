module top_module (
    input clk,
    input j,
    input k,
    output Q);
    wire D;
    always @(posedge clk) begin
        Q <= D;
    end
    assign D = (j & ~Q) | (~k & Q);

endmodule
