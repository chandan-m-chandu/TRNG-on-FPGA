module tb_clk_wiz_0;

    reg clk_in = 0;
    reg rst = 1;

    wire clk_out1;
    reg psen = 0;
    reg psincdec = 0;
    wire psdone;

    // Clock generation
    always #5 clk_in = ~clk_in;

    // Instantiate DUT
    clk_wiz_0 uut (
        .clk_in1(clk_in),
        .clk_out1(clk_out1),
        .reset(rst),
        .psclk(clk_in),
        .psen(psen),
        .psincdec(psincdec),
        .psdone(psdone),
        .locked()
    );

    initial begin
        #20 rst = 0;
        psen = 1;
        #10;
        psincdec = 1;
        #10;
        psen = 0;
        psincdec = 0;       
        
        #1000 $finish;
    end

endmodule
