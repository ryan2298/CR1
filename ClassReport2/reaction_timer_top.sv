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
    input logic clk,
    input logic [5:0] btn,
    output logic [15:0] led,
    output logic [7:0] an,
    output logic [7:0] sseg
    );
    
    reaction_timer uut(
        .clk(clk),
        .clear(btn[0]),
        .start(btn[1]),
        .stop(btn[2]),
        .led(led[0]),
        .an(an[7:4]),
        .sseg(sseg)
    );
endmodule
