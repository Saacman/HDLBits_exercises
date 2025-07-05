module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] d;
    
    always @(posedge clk) begin
        if(reset)
            out <= 32'b0;
        else begin
            out <= out | (~in & d);
            
        end
        d <= in;
    end
endmodule
