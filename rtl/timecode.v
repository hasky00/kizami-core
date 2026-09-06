// timecode.v — HH:MM:SS:FF counter at 25 fps from the Alhambra II 12 MHz clock
// 12,000,000 / 25 = 480,000 cycles per frame. 24 fps = 500000, 30 fps = 400000.
module timecode #(
    parameter FRAME_DIV = 480000,
    parameter FPS_MAX   = 24
) (
    input  wire       clk,
    output reg  [4:0] ff,
    output reg  [5:0] ss,
    output reg  [5:0] mm,
    output reg  [4:0] hh,
    output reg        tick
);
    reg [18:0] div;
    initial begin ff = 0; ss = 0; mm = 0; hh = 0; tick = 0; div = 0; end

    always @(posedge clk) begin
        if (div == FRAME_DIV - 1) begin div <= 0; tick <= 1; end
        else begin div <= div + 1; tick <= 0; end
    end

    always @(posedge clk) if (tick) begin
        if (ff == FPS_MAX) begin
            ff <= 0;
            if (ss == 59) begin
                ss <= 0;
                if (mm == 59) begin mm <= 0; hh <= (hh == 23) ? 0 : hh + 1; end
                else mm <= mm + 1;
            end else ss <= ss + 1;
        end else ff <= ff + 1;
    end
endmodule
