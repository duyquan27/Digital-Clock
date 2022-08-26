`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:	21:26:53 06/19/2021
// Design Name:
// Module Name:	alarm
// Project Name:
// Description:
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////// module aclock (
input reset, /* reset tich cuc muc cao, dong ho ngung hoat dong dung de reset thoi gian cua ngo vao gio va phut (cac ngo: H_in1, H_in0, M_in1, M_in0), dat ngo ra Alarm = 0. khi dong ho hoat dong binh thuong thi reset = 0*/
input clk, /* ngo vao xung clock 1Hz.*/
input [1:0] H_in1, /*2-bit gio ngo vao trong so cao cua dong ho khi (LD_time = 1) hoac la bit gio ngo vao trong so cao cua bao thuc khi (LD_alarm = 1). gia tri tu 0 den 2.*/
input [3:0] H_in0, /*4-bit gio ngo vao trong so thap cua dong ho khi (LD_time = 1) hoac la bit gio ngo vao trong so thap cua bao thuc khi (LD_alarm = 1). gia tri tu 0 den 9.*/
input [3:0] M_in1, /*4-bit phut ngo vao trong so cao cua dong ho khi (LD_time = 1) hoac la bit gio ngo vao trong so cao cua bao thuc khi (LD_alarm = 1). gia tri tu 0 den 5.*/
input [3:0] M_in0, /*4-bit phut ngo vao trong so thap cua dong ho khi (LD_time = 1) hoac la bit gio ngo vao trong so thap cua bao thuc khi (LD_alarm = 1). gia tri tu 0 den 9.*/

input LD_time, /* neu LD_time = 1, dung de dat gia tri ngo vao H_in1, H_in0, M_in1, M_in0 cho dong ho. giay mac dinh = 00. neu LD_time = 0,dong ho hoat dong binh thuong (giay tang them 1 sau moi 10 chu ky xung clock). */
input LD_alarm, /* neu LD_alarm = 1, dung de dat gia tri ngo vao H_in1, H_in0, M_in1, M_in0 cho bao thuc. Neu LD_alarm = 0, dong ho hoat dong binh thuong*/ input STOP_al, /* khi ngo ra Alarm = 1, neu STOP_al = 1 thi ngay luc do Alarm = 0.
*/
input AL_ON, /* neu AL_ON = 1 thi bao thuc bat(Alarm = 1 neu thoi gian ngo ra bang thoi gian bao thuc). neu AL_ON = 0 thi chuc nang bao thuc tat. */

output reg Alarm, /* Alarm = 1 khi thoi gian ngo ra bang thoi gian bao thuc va AL_ON = 1. Alarm duy tri muc 1 cho den khi STOP_al = 1 thi Alarm = 0*/ output [1:0] H_out1, /* 2 bit gio ngo ra trong so cao . gia tri tu 0 den 2. */ output [3:0] H_out0, /* 4 bit gio ngo ra trong so thap . gia tri tu 0 den 9. */ output [3:0] M_out1, /* 4 bit phut ngo ra trong so cao . gia tri tu 0 den 5. */ output [3:0] M_out0, /* 4 bit phut ngo ra trong so thap . gia tri tu 0 den 9. */ output [3:0] S_out1, /* 4 bit giay ngo ra trong so cao . gia tri tu 0 den 5. */ output [3:0] S_out0 /* 4 bit giay ngo ra trong so thap . gia tri tu 0 den 9. */
);
// tin hieu ben trong module reg clk_1s; // xung clock 1s
reg [3:0] tmp_1s; // dem tao xung clock 1s
reg [5:0] tmp_hour, tmp_minute, tmp_second;
// bo dem gio, phut, giay reg [1:0] c_hour1,a_hour1;
/* 2-bit gio trong so cao cua dong ho va bao thuc tam thoi */ reg [3:0] c_hour0,a_hour0;
/* 4-bit gio trong so thap cua dong ho va bao thuc tam thoi */ reg [3:0] c_min1,a_min1;
/* 4-bit phut trong so cao cua dong ho va bao thuc tam thoi */ reg [3:0] c_min0,a_min0;
/* 4-bit phut trong so thap cua dong ho v bao thuc tam thoi */ reg [3:0] c_sec1,a_sec1;
/* 4-bit giay trong cao thap cua dong ho va bao thuc tam thoi */ reg [3:0] c_sec0,a_sec0;
/* 4-bit giay trong so thap cua dong ho va bao thuc tam thoi */


/*************************************************/
/*************** TAO XUNG CLOCK 1s****************/
/*************************************************/ 
always @(posedge clk or posedge reset)
begin if(reset) begin tmp_1s <= 0;
clk_1s <= 0; end
else begin
tmp_1s <= tmp_1s + 1; if(tmp_1s <= 5)
clk_1s <= 0;
else if (tmp_1s >= 10) begin clk_1s <= 1;
tmp_1s <= 1; end
else
clk_1s <= 1; end
end


/*************************************************/
/*************HOAT DONG CUA DONG HO***************/
/*************************************************/
always @(posedge clk_1s or posedge reset )
begin
if(reset) begin // reset high => gio bao thuc = 00.00.00, Alarm = 0, gio cua H_in,
M_in, Sec = 00 a_hour1 <= 2'b00; a_hour0 <= 4'b0000; a_min1 <= 4'b0000; a_min0 <= 4'b0000; a_sec1 <= 4'b0000; a_sec0 <= 4'b0000;
tmp_hour <= H_in1*10 + H_in0; tmp_minute <= M_in1*10 + M_in0; tmp_second <= 0;
end
else begin
// dat bao thuc cho dong ho
if(LD_alarm) begin // LD_alarm = 1 => dat gio bao thuc vao H_in, M_in a_hour1 <= H_in1;
a_hour0 <= H_in0; a_min1 <= M_in1; a_min0 <= M_in0; a_sec1 <= 4'b0000; a_sec0 <= 4'b0000; end
// dat gio cho dong ho
if(LD_time) begin // LD_time = 1 => dat gio cho dong ho vao H_in, M_in tmp_hour <= H_in1*10 + H_in0;
tmp_minute <= M_in1*10 + M_in0; tmp_second <= 0;
end
// dong ho hoat dong binh thuong LD_time = 0, reset = 0, dong ho hoat dong binh thuong
else begin

tmp_second <= tmp_second + 1;
if(tmp_second >=59) begin // giay > 59 => phut tang 1 tmp_minute <= tmp_minute + 1;
tmp_second <= 0;
if(tmp_minute >=59) begin // phut > 59 => giay tang 1 tmp_minute <= 0;
tmp_hour <= tmp_hour + 1;
if(tmp_hour >= 23) begin // gio > 23 => gio = 0 tmp_hour <= 0;
end end end

end end end
/************************************************/
/*****************BO DEM MOD10******************/
/*************************************************/ function [3:0] mod_10;
input [5:0] number; begin
mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >=
20)? 2 :((number >= 10)? 1 :0))));
end endfunction
/*************************************************/
/***********NGO RA CUA DONG HO********************/
/*************************************************/ always @(*) begin
if(tmp_hour>=20) begin c_hour1 = 2;

end
else begin if(tmp_hour >=10)
c_hour1 = 1; else
c_hour1 = 0; end
c_hour0 = tmp_hour - c_hour1*10; c_min1 = mod_10(tmp_minute); c_min0 = tmp_minute - c_min1*10; c_sec1 = mod_10(tmp_second); c_sec0 = tmp_second - c_sec1*10; end
assign H_out1 = c_hour1; // bit gio trong so cao cua dong ho assign H_out0 = c_hour0; // bit gio trong so thap cua dong ho assign M_out1 = c_min1; // bit phut trong so cao cua dong ho assign M_out0 = c_min0; // bit phut trong so thap cua dong ho assign S_out1 = c_sec1; // bit giay trong so cao cua dong ho assign S_out0 = c_sec0; // bit giay trong so thap cua dong ho

/*************************************************/
/***************CHUC NANG BAO THUC***************/
/*************************************************/ always @(negedge clk_1s or posedge reset) begin
if(reset) Alarm <=0; else begin

if({a_hour1,a_hour0,a_min1,a_min0,a_sec1,a_sec0}=={c_hour1,c_hour0,c_min1,c_m in0,c_sec1,c_sec0})
begin

if(AL_ON) Alarm <= 1; // khi AL_ON = 1, thoi gian bao thuc bang voi thoi gian ngo ra cua dong ho thi Alarm = 1
end
if(STOP_al) Alarm <=0; // khi STOP_al = 1 thi Alarm = 0 end
end endmodule
