
module trng_core (
    input wire clk,
    input wire rst,
    input wire enable,
    input wire bit_in,
    output reg [31:0] random_data,
    output reg valid
);

    reg [4:0] count;

    always @(posedge clk) begin
        if (rst || !enable) begin
            random_data <= 0;
            count <= 0;
            valid <= 0;
        end else begin
            random_data <= {random_data[30:0], bit_in};
            count <= count + 1;
            valid <= (count == 31);
        end
    end
endmodule
