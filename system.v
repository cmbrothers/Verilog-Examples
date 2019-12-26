`timescale 1ns / 1ps

//system wrapper module. Sets up clock division to run sevenseg module then connect said module and switches to 
//to the memory system for operation.
//switches 0 to 7 function to set input data, 8 to 10 sets address of byte to be accessed while switch 11 
//governs whether to read from or write data to the byte. BTNC is used to trigger the latch of data once
//address is dialed in. the CPU_RESETN button is inverted to function as reset for the display module and
//clock divider in the event of erroneous operation.
module system(
    input [11:0] sw,
    input clk, BTNC, CPU_RESETN,
    output [11:0] led,
    output [6:0] seg,
    output [7:0] an
    );
    
    wire clock;
    wire [7:0] data;
    
    assign led = sw;
    
    clockdivider #(.DIV(100000), .WIDTH(17)) CLK0 (.IN(clk), .RST(~CPU_RESETN), .OUT(clock));
    
    sevenseg SEG0(.CLK(clock), .RST(~CPU_RESETN), .I0(sw[3:0]), .I1(sw[7:4]), .I2(0), .I3(0), .I4(sw[10:8]), .I5(0), .I6(data[3:0]), .I7(data[7:4]), .sA(seg[0]), .sB(seg[1]), .sC(seg[2]), .sD(seg[3]), .sE(seg[4]), .sF(seg[5]), .sG(seg[6]), .AN(an)); 
    
    mem_bank MEM0(.DATA_IN(sw[7:0]), .RW(sw[11]), .LATCH(BTNC), .ADRS(sw[10:8]), .DATA_OUT(data));   
    
endmodule
