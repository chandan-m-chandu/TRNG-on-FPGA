
module TRNG (
    input  wire clk_in,
    input  wire rst,
    output wire [31:0] random_data,
    output wire        valid
);

    wire clk_out_dcm;
    wire psen, psincdec, psdone;
    wire enable_sampling;
    wire meta_bit;

    // FSM
    dcm_tuner tuner (
        .clk(clk_in),
        .rst(rst),
        .metastable_bit(meta_bit),
        .psen(psen),
        .psincdec(psincdec),
        .enable_sampling(enable_sampling)
    );

    // Clocking Wizard IP instantiation  
    clk_wiz_0 dcm_inst (
        .clk_in1(clk_in),
        .clk_out1(clk_out_dcm),
        .psclk(clk_in),
        .psen(psen),
        .psincdec(psincdec),
        .psdone(psdone),
        .reset(rst),
        .locked() // optional
    );
    
    // Core: CARRY4 + FF XOR
    metastable_core core (
        .clk_in(clk_in),
        .clk_out(clk_out_dcm),
        .rst(rst),
        .metastable_bit(meta_bit)
    );

    // Bit collector
    wire [31:0] raw_data;
    wire raw_valid;

    trng_core bitstream (
        .clk(clk_in),
        .rst(rst),
        .enable(~enable_sampling),
        .bit_in(meta_bit),
        .random_data(raw_data),
        .valid(raw_valid)
    );

    // Post-processing
    post_process post (
        .clk(clk_in),
        .rst(rst),
        .valid_in(raw_valid),
        .random_in(raw_data),
        .valid_out(valid),
        .random_out(random_data)
    );

endmodule
