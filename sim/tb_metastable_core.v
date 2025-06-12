`timescale 1ns / 1ps

module tb_metastable_core;

    reg clk_in = 0;
    reg clk_out = 0;
    reg rst = 1;

    wire metastable_bit;

    // Clocks
    always #5 clk_in = ~clk_in;
    always #4 clk_out = ~clk_out;  // Slight phase offset

    metastable_core uut (
        .clk_in(clk_in),
        .clk_out(clk_out),
        .rst(rst),
        .metastable_bit(metastable_bit)
    );

    initial begin
        #20 rst = 0;
        #500 $finish;
    end

    always @(posedge clk_in)
        $display("%0t\tMetastable Bit = %b", $time, metastable_bit);

endmodule

