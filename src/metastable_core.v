module metastable_core (
    input  wire clk_in,
    input  wire clk_out,
    input  wire rst,
    
    output wire metastable_bit
);

    wire [3:0] carry_out;
    reg  [3:0] sampled;

    CARRY4 carry_inst (                        //    CARRY4 is inbuilt logic of Xilinx
        .CI     (1'b0),
        .CYINIT (clk_out),
        .DI     (4'b1111),
        .S      (4'b0000),
        .O      (carry_out)
    );
    
    always @(posedge clk_in) begin
        if (rst)
            sampled <= 4'b0;
        else
            sampled <= carry_out;
    end

    assign metastable_bit = ^sampled;

endmodule
