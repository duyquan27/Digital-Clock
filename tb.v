`timescale 1ns / 1ps


////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:  21:28:44 06/19/2021
// Design Name:  aclock
// Module Name:  D:/alarm/test.v
// Project Name: alarm
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: aclock
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////



module test;
// Inputs reg reset; reg clk;
reg [1:0] H_in1;
reg [3:0] H_in0;
reg [3:0] M_in1;
reg [3:0] M_in0; reg LD_time; reg LD_alarm; reg STOP_al; reg AL_ON;
// Outputs wire Alarm;
wire [1:0] H_out1;
wire [3:0] H_out0;
wire [3:0] M_out1;
wire [3:0] M_out0;
wire [3:0] S_out1;
wire [3:0] S_out0;
// Instantiate the Unit Under Test (UUT) aclock uut (
.reset(reset),
.clk(clk),
.H_in1(H_in1),
.H_in0(H_in0),
.M_in1(M_in1),
.M_in0(M_in0),
.LD_time(LD_time),
.LD_alarm(LD_alarm),
.STOP_al(STOP_al),

.AL_ON(AL_ON),
.Alarm(Alarm),
.H_out1(H_out1),
.H_out0(H_out0),
.M_out1(M_out1),
.M_out0(M_out0),
.S_out1(S_out1),
.S_out0(S_out0)
);
// clock 10Hz initial begin clk = 0;
forever #50 clk = ~clk; end
initial begin
// test chuc nang reset, chuc nang dat bao thuc
//ngung dong ho va khoi tao thoi gian 23h58p00s reset = 1;
H_in1 = 2;
H_in0 = 3;
M_in1 = 5;
M_in0 = 8;
LD_time = 0;
LD_alarm = 0;
STOP_al = 0;
AL_ON = 0;
//cho dong ho chay va cai bao thuc luc 23h59p #1000
reset = 0;
H_in1 = 2;
H_in0 = 3;
M_in1 = 5;

M_in0 = 9;
LD_time = 0;
LD_alarm = 1;
STOP_al = 0;
AL_ON = 1; //cho phep bao thuc #1000
LD_alarm = 0;
//doi 65us sau do reset tao 1 xung reset canh len cho Alarm = 0 #65000
reset = 1;
// doi 1us sau do tha nut reset dong ho hoat dong binh thuong va bao thuc vao luc 00h00p00s
#1000 reset = 0;
H_in1 = 2;
H_in0 = 3;
M_in1 = 5;
M_in0 = 9;
LD_time = 0;
LD_alarm = 0;
STOP_al = 0;
AL_ON = 1;


// test tat bao thuc bang STOP_al
// ngung dong ho va khoi tao thoi gian 10h14p00s, thoi gian bao thuc la 00h00 khi reset
#100000
reset = 1;
H_in1 = 1;
H_in0 = 0;
M_in1 = 1;
M_in0 = 4;
LD_time = 0;

LD_alarm = 0;
STOP_al = 0;
AL_ON = 0;


//bat Alarm va dat thoi gian cho bao thuc la 10h15p00s #10000
reset = 0;
H_in1 = 1;
H_in0 = 0;
M_in1 = 1;
M_in0 = 5;
LD_time = 0;
LD_alarm = 1;
STOP_al = 0;
AL_ON = 1;


#1000
reset = 0;
H_in1 = 1;
H_in0 = 0;
M_in1 = 1;
M_in0 = 5;
LD_time = 0;
LD_alarm = 0;
STOP_al = 0;
AL_ON = 1;
wait(Alarm); // doi den khi tin hieu Alarm = 1 vao luc ma thoi gian tren ngo ra dong ho bang thoi gian bao thuc
#2000
STOP_al = 1; // tin hieu STOP_al = 1 ngay lap tuc tin hieu Alarm = 0 #1000
STOP_al = 0;



//test AL_ON #60000
reset = 1;
H_in1 = 1;
H_in0 = 0;
M_in1 = 1;
M_in0 = 4;
LD_time = 0;
LD_alarm = 0;
STOP_al = 0;
AL_ON = 0;
#1000
reset = 0;
H_in1 = 1;
H_in0 = 0;
M_in1 = 1;
M_in0 = 5;
LD_time = 0;
LD_alarm = 1;
STOP_al = 0;
AL_ON = 0;



end endmodule