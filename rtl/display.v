// display.v — frame count FF on 2 multiplexed 7-seg digits
module display (
    input  wire       clk,
    input  wire [4:0] ff,
    output wire [6:0] seg,   // shared segment lines
    output reg  [1:0] dig    // digit select, active-low (common cathode)
);
    // tens / units split — the same BCD split LTC needs later
    wire [3:0] f10 = ff / 10;
    wire [3:0] f1  = ff % 10;

    // scan ~1.5 kHz: 12 MHz / 8192, top bit picks the digit
    reg [12:0] scan = 0;
    always @(posedge clk) scan <= scan + 1;
    wire idx = scan[12];

    reg [3:0] cur;
    always @* begin
        cur = idx ? f1 : f10;
        dig = idx ? 2'b01 : 2'b10;   // only one digit low at a time
    end

    seg7 dec (.d(cur), .seg(seg));
endmodule
