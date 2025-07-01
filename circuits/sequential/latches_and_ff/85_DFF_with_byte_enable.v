module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always @(posedge clk) begin
        if(!resetn)
            q <= 0;
        else begin
            for (int i = 0; i < $bits(byteena); i = i + 1) begin
                if (byteena[i])
                    q[i*8 +: 8] <= d[i*8 +: 8];
            end
        end
    end
endmodule
