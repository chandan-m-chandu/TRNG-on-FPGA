`timescale 1ns / 1ps

module tb_trng_top;

    // Inputs
    reg clk_in = 0;
    reg rst = 1;
    // Outputs
    wire [31:0] random_data;
    wire valid;

    always #2 clk_in = ~clk_in;

    // Instantiate the DUT
    TRNG uut (
        .clk_in(clk_in),
        .rst(rst),
        .random_data(random_data),
        .valid(valid)
    );

    // Reset sequence
    initial begin
        $display("==== TRNG Simulation Start ====");
        $display("Time(ns)\tValid\tRandom Data");       
    end

    always @(posedge clk_in) begin
    #5 rst = 0;
        if (valid) $display("%0t\t1\t%h", $time, random_data);
    #5000 $finish;        
    end

    
endmodule
