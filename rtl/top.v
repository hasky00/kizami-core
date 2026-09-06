// top.v — timecode on LEDs + frame count on a 2-digit 7-seg
module top (
    input  wire       CLK,   // 12 MHz
    output wire [7:0] LED,
    output wire [6:0] SEG,   // D0..D6
    output wire [1:0] DIG    // D7, D8
);
    wire [4:0] ff;  wire [5:0] ss, mm;  wire [4:0] hh;  wire tick;

    timecode tc (.clk(CLK), .ff(ff), .ss(ss), .mm(mm), .hh(hh), .tick(tick));
    display  disp (.clk(CLK), .ff(ff), .seg(SEG), .dig(DIG));

    assign LED[4:0] = ff;
    assign LED[6:5] = 2'b00;
    assign LED[7]   = ss[0];
endmodule
