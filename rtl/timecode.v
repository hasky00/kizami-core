// timecode.v — HH:MM:SS:FF as BCD digit counters (odometer style), 25 fps
// Every field is two 4-bit digits: units roll 0..9 and carry into tens.
// No division needed, and this is exactly the layout the LTC frame wants.
module timecode #(
    parameter FRAME_DIV = 480000,   // 12 MHz / 25 fps
    parameter FPS_TENS  = 2,        // last frame = 24 -> tens 2, units 4
    parameter FPS_UNITS = 4
) (
    input  wire       clk,
    output reg  [3:0] f1, f10,      // frames  units / tens
    output reg  [3:0] s1, s10,      // seconds
    output reg  [3:0] m1, m10,      // minutes
    output reg  [3:0] h1, h10,      // hours
    output reg        tick
);
    reg [18:0] div;
    initial begin
        f1=0; f10=0; s1=0; s10=0; m1=0; m10=0; h1=0; h10=0; tick=0; div=0;
    end

    always @(posedge clk) begin
        if (div == FRAME_DIV - 1) begin div <= 0; tick <= 1; end
        else begin div <= div + 1; tick <= 0; end
    end

    // "last value" tests, all on 4-bit digits — cheap compares, no math
    wire f_last = (f10 == FPS_TENS) && (f1 == FPS_UNITS);
    wire s_last = (s10 == 5) && (s1 == 9);
    wire m_last = (m10 == 5) && (m1 == 9);
    wire h_last = (h10 == 2) && (h1 == 3);

    always @(posedge clk) if (tick) begin
        if (f_last) begin
            f1 <= 0; f10 <= 0;
            if (s_last) begin
                s1 <= 0; s10 <= 0;
                if (m_last) begin
                    m1 <= 0; m10 <= 0;
                    if (h_last) begin h1 <= 0; h10 <= 0; end
                    else if (h1 == 9) begin h1 <= 0; h10 <= h10 + 1; end
                    else h1 <= h1 + 1;
                end else if (m1 == 9) begin m1 <= 0; m10 <= m10 + 1; end
                else m1 <= m1 + 1;
            end else if (s1 == 9) begin s1 <= 0; s10 <= s10 + 1; end
            else s1 <= s1 + 1;
        end else if (f1 == 9) begin f1 <= 0; f10 <= f10 + 1; end
        else f1 <= f1 + 1;
    end
endmodule
