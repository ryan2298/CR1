`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 09:41:04 PM
// Design Name: 
// Module Name: clockwise_segment_controller_t
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


module clockwise_segment_controller_t;
logic clk;
logic rst;
logic up;
logic en;
logic tic;
logic cw;
logic [3:0] an;
logic [7:0] sseg;

seven_seg_controller DUT(.clk(clk),.rst(rst),.up(up),.en(en),.tic(tic),.cw(cw),.an(an),.sseg(sseg));
    
    initial begin
        clk=0;
        forever
            #5 clk = !clk;
    end
    
    initial begin
        rst = 0;
        up = 1'b1;
        en = 1'b1;
        cw = 1'b1;
        #3 rst = 1;
        #3 rst = 0;
        #4;
    end


endmodule
