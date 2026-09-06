// top.v — wires the timecode counter to the Alhambra II user LEDs.
// LED0..LED4 show the frame count (0-24) in binary, LED7 blinks once per second.

module top (
    input  wire       CLK,          // 12 MHz MEMS oscillator
    output wire [7:0] LED
);

    wire [4:0] ff;
    wire [5:0] ss, mm;
    wire [4:0] hh;
    wire       tick;

    timecode tc (
        .clk (CLK),
        .ff  (ff), .ss (ss), .mm (mm), .hh (hh),
        .tick(tick)
    );

    assign LED[4:0] = ff;
    assign LED[6:5] = 2'b00;
    assign LED[7]   = ss[0];        // toggles every second
endmodule
