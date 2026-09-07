// display.v — frame count on 2 multiplexed 7-seg digits (BCD in, no division)
module display (
    input  wire       clk,
    input  wire [3:0] f10, f1,
    output wire [6:0] seg,
    output reg  [1:0] dig
);
    reg [12:0] scan = 0;
    always @(posedge clk) scan <= scan + 1;
    wire idx = scan[12];

    reg [3:0] cur;
    always @* begin
        cur = idx ? f1 : f10;
        dig = idx ? 2'b01 : 2'b10;
    end
    seg7 dec (.d(cur), .seg(seg));
endmodule
