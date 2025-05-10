// synthesis verilog_input_version verilog_2001
module top_module ( 
    input [2:0] sel, 
    input [3:0] data0,
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    output reg [3:0] out   );//

    always@(*) begin  // This is a combinational circuit
        case(sel)
            'b000: out = data0;
            'b001: out = data1;
            'b010: out = data2;
            'b011: out = data3;
            'b100: out = data4;
            'b101: out = data5;
            default: out = 'b0;
        endcase
    end

endmodule