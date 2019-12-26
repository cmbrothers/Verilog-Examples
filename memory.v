`timescale 1ns / 1ps

//defines one 8byte memory block using previously defined byte sections and uses demux for selecting 
//which byte in the block data is latched to. Bytes are read using same select lines via mulitplexed 
//output and position of RW bit, 0 for read, 1 for write
module mem_bank(
    input [7:0] DATA_IN,
    input [2:0] ADRS,
    input RW, LATCH,
    output [7:0] DATA_OUT
    );
    
    wire [7:0] latch;   
    wire [7:0] N_0;
    wire [7:0] N_1;
    wire [7:0] N_2;
    wire [7:0] N_3;
    wire [7:0] N_4;
    wire [7:0] N_5;
    wire [7:0] N_6;
    wire [7:0] N_7;
    
    demux mem_control(.SEL(ADRS), .EN(RW), .Y(LATCH), .I(latch));
    
    mem_byte NUM0(.DATA(DATA_IN), .LATCH(latch[0]), .OUT(N_0), .NOT_OUT());
    mem_byte NUM1(.DATA(DATA_IN), .LATCH(latch[1]), .OUT(N_1), .NOT_OUT());
    mem_byte NUM2(.DATA(DATA_IN), .LATCH(latch[2]), .OUT(N_2), .NOT_OUT());
    mem_byte NUM3(.DATA(DATA_IN), .LATCH(latch[3]), .OUT(N_3), .NOT_OUT());
    mem_byte NUM4(.DATA(DATA_IN), .LATCH(latch[4]), .OUT(N_4), .NOT_OUT());
    mem_byte NUM5(.DATA(DATA_IN), .LATCH(latch[5]), .OUT(N_5), .NOT_OUT());
    mem_byte NUM6(.DATA(DATA_IN), .LATCH(latch[6]), .OUT(N_6), .NOT_OUT());
    mem_byte NUM7(.DATA(DATA_IN), .LATCH(latch[7]), .OUT(N_7), .NOT_OUT());
    
    mux OUT0 (.Y(DATA_OUT[0]), .SEL(ADRS), .EN(~RW), .I0(N_0[0]), .I1(N_1[0]), 
    .I2(N_2[0]), .I3(N_3[0]), .I4(N_4[0]), .I5(N_5[0]), .I6(N_6[0]), .I7(N_7[0]));
    
    mux OUT1 (.Y(DATA_OUT[1]), .SEL(ADRS), .EN(~RW), .I0(N_0[1]), .I1(N_1[1]), 
    .I2(N_2[1]), .I3(N_3[1]), .I4(N_4[1]), .I5(N_5[1]), .I6(N_6[1]), .I7(N_7[1]));
    
    mux OUT2 (.Y(DATA_OUT[2]), .SEL(ADRS), .EN(~RW), .I0(N_0[2]), .I1(N_1[2]), 
    .I2(N_2[2]), .I3(N_3[2]), .I4(N_4[2]), .I5(N_5[2]), .I6(N_6[2]), .I7(N_7[2]));
    
    mux OUT3 (.Y(DATA_OUT[3]), .SEL(ADRS), .EN(~RW), .I0(N_0[3]), .I1(N_1[3]), 
    .I2(N_2[3]), .I3(N_3[3]), .I4(N_4[3]), .I5(N_5[3]), .I6(N_6[3]), .I7(N_7[3]));
    
    mux OUT4 (.Y(DATA_OUT[4]), .SEL(ADRS), .EN(~RW), .I0(N_0[4]), .I1(N_1[4]), 
    .I2(N_2[4]), .I3(N_3[4]), .I4(N_4[4]), .I5(N_5[4]), .I6(N_6[4]), .I7(N_7[4]));
    
    mux OUT5 (.Y(DATA_OUT[5]), .SEL(ADRS), .EN(~RW), .I0(N_0[5]), .I1(N_1[5]), 
    .I2(N_2[5]), .I3(N_3[5]), .I4(N_4[5]), .I5(N_5[5]), .I6(N_6[5]), .I7(N_7[5]));
    
    mux OUT6 (.Y(DATA_OUT[6]), .SEL(ADRS), .EN(~RW), .I0(N_0[6]), .I1(N_1[6]), 
    .I2(N_2[6]), .I3(N_3[6]), .I4(N_4[6]), .I5(N_5[6]), .I6(N_6[6]), .I7(N_7[6]));
    
    mux OUT7 (.Y(DATA_OUT[7]), .SEL(ADRS), .EN(~RW), .I0(N_0[7]), .I1(N_1[7]), 
    .I2(N_2[7]), .I3(N_3[7]), .I4(N_4[7]), .I5(N_5[7]), .I6(N_6[7]), .I7(N_7[7]));
    
    
endmodule

//Defines single byte of memory via replication and adressing of 8 individual D-latches
module mem_byte(
    input [7:0] DATA,
    input LATCH,
    output [7:0] OUT,
    output [7:0] NOT_OUT
    );
    
    mem_cell CEL0 (.DATA(DATA[0]), .LATCH(LATCH), .Q(OUT[0]), .QNOT(NOT_OUT[0]));
    mem_cell CEL1 (.DATA(DATA[1]), .LATCH(LATCH), .Q(OUT[1]), .QNOT(NOT_OUT[1]));
    mem_cell CEL2 (.DATA(DATA[2]), .LATCH(LATCH), .Q(OUT[2]), .QNOT(NOT_OUT[2]));
    mem_cell CEL3 (.DATA(DATA[3]), .LATCH(LATCH), .Q(OUT[3]), .QNOT(NOT_OUT[3]));
    mem_cell CEL4 (.DATA(DATA[4]), .LATCH(LATCH), .Q(OUT[4]), .QNOT(NOT_OUT[4]));
    mem_cell CEL5 (.DATA(DATA[5]), .LATCH(LATCH), .Q(OUT[5]), .QNOT(NOT_OUT[5]));
    mem_cell CEL6 (.DATA(DATA[6]), .LATCH(LATCH), .Q(OUT[6]), .QNOT(NOT_OUT[6]));
    mem_cell CEL7 (.DATA(DATA[7]), .LATCH(LATCH), .Q(OUT[7]), .QNOT(NOT_OUT[7])); 
    
endmodule

//Definition of D-Latch to be used as single bit memory cell
module mem_cell(
    input DATA, LATCH,
    output Q, QNOT
    );
    
    wire d, l;
    reg q, qnot;
    
    assign d = DATA;
    assign l = LATCH;
    
    always@(d or l)
        if(l)begin
            q <= d;
            qnot <= ~d;
        end
    
    assign Q = q;
    assign QNOT = qnot;
    
endmodule

//Case definition of demux for triggering latch of data byte by byte
module demux(
    input [2:0] SEL,
    input EN, Y,
    output [7:0] I
    );
    
    wire [2:0] sel;
    wire en, y;
    reg [7:0] i;
    
    assign y = Y;
    assign sel = SEL;
    assign en = EN;
    
    always@(*)
        if(en)begin
            case(sel)
            3'd0: i[0] = y;
            3'd1: i[1] = y;
            3'd2: i[2] = y;
            3'd3: i[3] = y;
            3'd4: i[4] = y;
            3'd5: i[5] = y;
            3'd6: i[6] = y;
            3'd7: i[7] = y;
            endcase
        end
            
    assign I = i;
    
endmodule


//Behavioral definition of mux. To be used for Tying output of each byte to output.
module mux(
    input I0, I1, I2, I3, I4, I5, I6, I7, EN,
    input [2:0] SEL,
    output Y
    );
    
    reg y;
    
    always@(*)
        if(EN)begin
            y = (SEL == 0)?  I0 : (SEL == 1)? I1 : (SEL == 2)? I2 : (SEL == 3)? 
            I3 : (SEL == 4)? I4 : (SEL == 5)? I5 : (SEL == 6)? I6 : I7 ;
        end
    
    assign Y = y;
    
endmodule
