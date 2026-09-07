// top.v — BCD timecode on LEDs + 8-digit 7-seg slate
module top (
    input  wire       CLK,
    output wire [7:0] LED,
    output wire [6:0] SEG,
    output wire [7:0] DIG
);
    wire [3:0] f1, f10, s1, s10, m1, m10, h1, h10;
    wire tick;
    timecode tc (.clk(CLK),
        .f1(f1), .f10(f10), .s1(s1), .s10(s10),
        .m1(m1), .m10(m10), .h1(h1), .h10(h10), .tick(tick));
    display disp (.clk(CLK),
        .h10(h10), .h1(h1), .m10(m10), .m1(m1),
        .s10(s10), .s1(s1), .f10(f10), .f1(f1),
        .seg(SEG), .dig(DIG));
    assign LED[3:0] = f1;
    assign LED[5:4] = f10[1:0];
    assign LED[6]   = 1'b0;
    assign LED[7]   = s1[0];
endmodule
