module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    wire d;
    // Combinational logic
    assign d = L ? r_in : q_in;
    
    // Sequential logic
    always @(posedge clk)begin
        Q <= d;
    end
endmodule
