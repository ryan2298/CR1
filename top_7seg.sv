`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 04:45:11 PM
// Design Name: 
// Module Name: top_7seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_7seg(
    input logic clk,
    input logic [1:0] sw,
    output logic [7:0] sseg,
    output logic [7:0] an
    );
    assign en = 1'b1;
    seven_seg_controller my_controller(.clk(clk),.rst(sw[1]),.cw(sw[0]),.en(en),.sseg(sseg),.an(an));
endmodule
