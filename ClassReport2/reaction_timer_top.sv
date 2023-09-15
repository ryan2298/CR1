`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 02:09:18 PM
// Design Name: 
// Module Name: reaction_timer_top
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


module reaction_timer_top(
    input clk,
    input BTNC,
    input BTND,
    input BTNU,
    output led,
    output [3:0] an,
    output [7:0] sseg
    );
    
    reaction_timer uut(
        .clk(clk),
        .clear(BTNC),
        .start(BTNU),
        .stop(BTND),
        .led(led),
        .an(an),
        .sseg(sseg)
    );
endmodule
