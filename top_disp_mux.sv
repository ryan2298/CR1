`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 03:04:06 PM
// Design Name: 
// Module Name: top_disp_mux
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


module top_disp_mux();

module disp_mux(clk,reset,in15,.in14,.in13,.in12
    input logic [7:0] in12, //top, fourth sseg
    input logic [7:0] in11, //top, fifth sseg
    input logic [7:0] in10, //top, sixth sseg
    input logic [7:0] in9, //top, seventh sseg
    input logic [7:0] in8, //top, right-most sseg
    input logic [7:0] in7, //bottom, left-most sseg
    input logic [7:0] in6, //bottom, second sseg
    input logic [7:0] in5, //bottom, third sseg
    input logic [7:0] in4, //bottom, fourth sseg
    input logic [7:0] in3, //bottom, fifth sseg
    input logic [7:0] in2, //bottom, sixth sseg
    input logic [7:0] in1, //bottom, seventh sseg
    input logic [7:0] in0, //bottom, right-most sseg
    output logic [7:0] an, //enable
    output logic [7:0] sseg //led segments
    );


endmodule
