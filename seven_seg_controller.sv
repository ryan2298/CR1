`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 08:29:54 PM
// Design Name: 
// Module Name: seven_seg_controller
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

module seven_seg_controller(
    input logic clk,
    input logic rst,
    input logic cw,
    input logic en, 
    output logic [7:0] an,
    output logic [7:0] sseg
    );
    parameter N_box_move = 30;
    
    logic [N_box_move-1:0] rotate_count;
    
    count_n #(N_box_move) display_counter(.clk(clk),.rst(rst),.up(!cw),.en(en),.count(rotate_count));

    decoder my_decoder(.code(rotate_count[N_box_move-1:N_box_move-4]), .an(an), .sseg(sseg));
    
endmodule
