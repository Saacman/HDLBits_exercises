module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    // Enables
    wire ss_en;
    wire [1:0] mm_en;
    wire hh_en;
    wire pm_en;
    // Seconds counters
    counter seconds0 (.clk(clk), .reset(reset), .enable(ena), .q(ss[3:0]));
    counter #(.DEPTH(6)) seconds1 (.clk(clk), .reset(reset), .enable(ss_en), .q(ss[7:4]));
    // Minutes counters
    counter minutes0 (.clk(clk), .reset(reset), .enable(mm_en[0]), .q(mm[3:0]));
    counter #(.DEPTH(6)) minutes1 (.clk(clk), .reset(reset), .enable(mm_en[1]), .q(mm[7:4]));
    // pm counter
    counter #(.DEPTH(2), .WIDTH(1)) pm0 (.clk(clk), .reset(reset), .enable(pm_en), .q(pm));
    
    assign ss_en = (ss[3:0] == 9) && ena;  
    assign mm_en = {mm[3:0] == 9 && mm_en[0],
                    ss[7:4] == 5 && ss_en};
    assign pm_en = hh[7:4] == 1 && hh[3:0] == 1 && hh_en;
    assign hh_en = mm[7:4] == 5 && mm_en[1];

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // 12
        end else if (hh_en) begin
            if (hh == 8'h12) begin
                hh <= 8'h01;
            end else if (hh[3:0] == 4'd9) begin
                hh[7:4] <= hh[7:4] + 1'b1;
                hh[3:0] <= 4'd0;
            end else begin
                hh[3:0] <= hh[3:0] + 1'b1;
            end
        end
    end  
endmodule

module counter #(
    DEPTH = 10,
    WIDTH = 4
)(
    input clk,
    input reset,
    input enable,
    output [WIDTH-1:0] q
);
    always @(posedge clk)begin
        if(reset)
            q <= 1'b0;
        else if (enable) begin
            if (q < DEPTH-1)
                q <= q+1'b1;
            else
                q <= 1'b0;
        end
    end

endmodule

