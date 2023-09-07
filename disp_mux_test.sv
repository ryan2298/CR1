`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 03:14:03 PM
// Design Name: 
// Module Name: disp_mux_test
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


module disp_mux_test(); 
    
    logic clk;
    logic [3:0] btn;
    logic [7:0] sw;
    logic [7:0] an;
    logic sel;
    logic [7:0] sseg;
    logic [7:0] d3_reg, d2_reg, d1_reg, d0_reg;
    
    disp_mux uut
        (.clk(clk), .reset(1'b0), .in0(d0_reg), .in1(d1_reg), .in2(d2_reg), .in3(d3_reg), .an(an), .sseg(sseg));
        
    always_ff @(posedge clk)
    begin
        if(btn[3])
            d3_reg <= sw;
        if(btn[2])
            d2_reg <= sw;
        if(btn[1])
            d1_reg <= sw;    
        if(btn[0])
            d0_reg <= sw;  
    end
    
    initial begin
    clk = 0;
    sw[7:0] = 8'b01010101;
    forever
        #5
        clk <= ~clk;
        $finish;
    end 
endmodule
