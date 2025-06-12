module post_process (
    input  wire        clk,
    input  wire        rst,
    input  wire        valid_in,
    input  wire [31:0] random_in,
    output reg         valid_out,
    output reg  [31:0] random_out
);

    reg [31:0] acc;
    reg [31:0] acc_sum;

    always @(posedge clk) begin
        if (rst) begin
            acc <= 0;
            valid_out <= 0;
        end else if (valid_in) begin
            acc_sum = acc + random_in;
            acc <= acc_sum;

            if (acc_sum[31] == 1)
                random_out <= acc_sum;
            else
                random_out <= ~acc_sum;

            valid_out <= 1;
        end else begin
            valid_out <= 0;
        end
    end
endmodule
