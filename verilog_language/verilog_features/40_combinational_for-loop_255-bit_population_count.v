module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    reg [7:0] out0;
    
    always @(*) begin
        out0 = 0;
        for(int i = 0; i < $bits(in); i++) begin
            out0 = in[i] + out0;
        end
    end
    assign out = out0;
endmodule