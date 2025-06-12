module dcm_tuner (
    input  wire clk,
    input  wire rst,
    input  wire metastable_bit,
    output reg  psen,
    output reg  psincdec,
    output reg  enable_sampling
);

    localparam IDLE = 2'd0,
               SHIFT = 2'd1,
               WAIT = 2'd2;

    reg [1:0] state = IDLE;
    reg [4:0] counter = 0;

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            psen <= 0;
            psincdec <= 0;
            enable_sampling <= 1;
            counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (metastable_bit == 0) begin
                        psen <= 1;
                        psincdec <= 0;
                        state <= SHIFT;
                    end
                end

                SHIFT: begin
                    psen <= 0;     // Pulse only 1 cycle
                    counter <= 0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    if (metastable_bit == 1) begin
                        enable_sampling <= 0;  // Lock
                        state <= IDLE;
                    end else if (counter == 20) begin
                        psen <= 1;
                        psincdec <= 0;
                        state <= SHIFT;
                    end
                end
            endcase
        end
    end

endmodule
