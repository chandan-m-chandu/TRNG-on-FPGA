`timescale 1ns / 1ps

module tb_dcm_tuner;

    reg clk = 0;
    reg rst = 1;
    reg metastable_bit = 0;

    wire psen, psincdec, enable_sampling;

    // Clock
    always #5 clk = ~clk;

    dcm_tuner uut (
        .clk(clk),
        .rst(rst),
        .metastable_bit(metastable_bit),
        .psen(psen),
        .psincdec(psincdec),
        .enable_sampling(enable_sampling)
    );

    initial begin
        $display("T\tpsen psincdec enable T_bit");

        #10 rst = 0;

        // Simulate 0 metastability initially
        repeat(10) begin
            metastable_bit = 0;
            #50;
        end

        // Simulate metastability triggered
        metastable_bit = 1;
        #100;

        $finish;
    end

    always @(posedge clk)
        $display("%0t\t%b %b %b %b", $time, psen, psincdec, enable_sampling, metastable_bit);

endmodule
