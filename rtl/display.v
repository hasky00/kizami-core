// display.v — HH:MM:SS:FF on 8 multiplexed 7-seg digits (BCD in)
module display (
    input  wire       clk,
    input  wire [3:0] h10, h1, m10, m1, s10, s1, f10, f1,
    output wire [6:0] seg,
    output reg  [7:0] dig      // active-low, one digit at a time
);
    reg [12:0] scan = 0;       // 12 MHz / 8192 -> ~1.5 kHz full cycle
    always @(posedge clk) scan <= scan + 1;
    wire [2:0] idx = scan[12:10];

    reg [3:0] cur;
    always @* begin
        case (idx)
            3'd0: cur = f1;   3'd1: cur = f10;
            3'd2: cur = s1;   3'd3: cur = s10;
            3'd4: cur = m1;   3'd5: cur = m10;
            3'd6: cur = h1;   default: cur = h10;
        endcase
        dig = ~(8'b1 << idx);
    end
    seg7 dec (.d(cur), .seg(seg));
endmodule
