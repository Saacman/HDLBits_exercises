module top_module(
	input clk,
	input reset,
	output [3:0] q);
	
	always @(posedge clk)
        if (reset || q == 10)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
			q <= 1;
		else
			q <= q+1;
	
endmodule