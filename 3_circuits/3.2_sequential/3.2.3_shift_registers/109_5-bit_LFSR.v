module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    wire tap_5 = 1'b0 ^ q[0];
    wire tap_3 = q[3] ^ q[0];
    
    always @(posedge clk) begin
        if(reset)
            q <= 5'h1;
        else begin
            q[4] <= tap_5;
            q[3] <= q[4];
            q[2] <= tap_3;
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end

endmodule
