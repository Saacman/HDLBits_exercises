module top_module(
    input  logic clk,
    input  logic load,
    input  logic [255:0] data,
    output logic [255:0] q
); 
    integer row, col;
    integer index;
    logic [255:0] next_q;

    always_comb begin
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                index = row * 16 + col;
                next_q[index] = cell_life(q[index], get_neighbors(q, row, col));
            end
        end
    end

    always_ff @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

    // Function to compute next cell state
    function logic cell_life(input logic current_cell, input logic [7:0] neighbors);
        int count = 0;
        for (int i = 0; i < 8; i++)
            count += neighbors[i];
        return current_cell? (count == 2 || count == 3): (count == 3);
    endfunction

    // Dummy neighbor extractor for now
    function logic [7:0] get_neighbors(input logic [255:0] grid, input int row, input int col);
        logic north, south, east, west, northeast, northwest, southeast, southwest;
        logic [4:0] up, down, left, right;
        up    = (row ==  0)? 4'd15 : row-1'b1;
        down  = (row == 15)? 4'd0  : row+1'b1;
        left  = (col ==  0)? 4'd15 : col-1'b1;
        right = (col == 15)? 4'd0  : col+1'b1;

        north = grid[up*16 + col];
        south = grid[down*16 + col];
        east = grid[row*16 + right];
        west = grid[row*16 + left];
        northeast = grid[up*16+ right];
        northwest = grid[up*16+ left];
        southeast = grid[down*16+ right];
        southwest = grid[down*16+ left];
        
        return {north, south, east, west,
            northeast, northwest, southeast, southwest};
    endfunction

endmodule