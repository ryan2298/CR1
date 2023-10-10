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
    output logic led,
    output logic [3:0] an,
    output logic [7:0] sseg
    );
    
    parameter N = 25;
    logic [9:0] timing;
    logic [1:0] state;
    logic [11:0] BCD_output;
    logic tic;
    
    
    counter_timer #(N) my_counter(
        .clk(clk),
        .rst(clear),
        .up(1'b1),
        .en(1'b1),
        .tic(tic)
    );
    
    BinaryToBCDConverter my_BCD(
        .bin(timing),
        .bcd(BCD_output)
    );
    
    sseg_decoder my_decoder(
        .tic_ms(tic),
        .state_system(state),
        .rst(clear),
        .bcd(BCD_output),
        .sseg(sseg),
        .an(an)
    );
    
    rand_delay wait_time(
        .tic(tic),
        .rst(clear),
        .stp(stop),
        .en(start),
        .state(state),
        .led(led),
        .timing(timing)
    );
endmodule