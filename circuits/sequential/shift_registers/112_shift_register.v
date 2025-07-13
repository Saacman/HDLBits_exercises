module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0] Q;
    always @(posedge clk) begin
        if(~resetn)
            Q <= 4'b0;
        else begin
            Q = {in, Q[3:1]};
        end
    end
    assign out = Q[0];

endmodule
