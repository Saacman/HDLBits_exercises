module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire d0, d1;
    // Combinational (Multiplexer)
    assign d0 = E? w: Q;
    assign d1 = L? R: d0;
    
    // Sequential (FF)
    always @(posedge clk) begin
        Q <= d1;
    end
endmodule
