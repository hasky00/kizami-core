// timecode.v — HH:MM:SS:FF counter at 25 fps from the Alhambra II 12 MHz clock
//
// 12,000,000 / 25 = 480,000 clock cycles per frame.
// Change FRAME_DIV to retarget fps:  24 fps = 500000, 30 fps = 400000.

module timecode #(
    parameter FRAME_DIV = 480000,   // clock cycles per frame
    parameter FPS_MAX   = 24        // last frame number (fps - 1)
) (
    input  wire       clk,          // 12 MHz
    output reg  [4:0] ff = 0,       // frames  0..FPS_MAX
    output reg  [5:0] ss = 0,       // seconds 0..59
    output reg  [5:0] mm = 0,       // minutes 0..59
    output reg  [4:0] hh = 0,       // hours   0..23
    output reg        tick = 0      // one-cycle pulse per frame
);

    reg [18:0] div = 0;             // 19 bits holds up to 524,287

    // frame tick generator
    always @(posedge clk) begin
        if (div == FRAME_DIV - 1) begin
            div  <= 0;
            tick <= 1;
        end else begin
            div  <= div + 1;
            tick <= 0;
        end
    end

    // the wall clock: frames -> seconds -> minutes -> hours carry chain
    always @(posedge clk) begin
        if (tick) begin
            if (ff == FPS_MAX) begin
                ff <= 0;
                if (ss == 59) begin
                    ss <= 0;
                    if (mm == 59) begin
                        mm <= 0;
                        hh <= (hh == 23) ? 0 : hh + 1;
                    end else mm <= mm + 1;
                end else ss <= ss + 1;
            end else ff <= ff + 1;
        end
    end
endmodule
