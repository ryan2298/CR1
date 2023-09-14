`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2023 06:28:47 PM
// Design Name: 
// Module Name: reaction_timer
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


module reaction_timer(
    input logic clk,
    input logic clear,
    input logic start,
    input logic stop,
    output logic [15:0] led,
    output logic [3:0] an,
    output logic [7:0] sseg
    );
    
    parameter N = 20;
    logic connect;
    logic internalWire;
    
    counter_timer #(N) uut(
        .clk(clk),
        .rst(clear),
        .up(1'b1),
        .en(), //NEEDS TO COME FROM RAND_DELAY
        .tick(connect), //Not sure if this is right
        .count() //Isn't needed anywhere
    );
    
    BinaryToBCDConverter dut(
        .bin(connect), //Right now, this is just 0 or 1 b/c its's tick, not a summation of ticks as count increments.
        .bcd(internalWire)
    );
    
    sseg_decoder but(
        .code(internalWire),
        .sseg(sseg),
        .an(an)
    );
    
endmodule
