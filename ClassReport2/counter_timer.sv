`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2023 07:06:33 PM
// Design Name: 
// Module Name: counter_timer
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


module counter_timer#(parameter N=20)(
    input logic clk,
    input logic rst,
    input logic up,
    input logic en,
    output logic tick,
    output logic [9:0] totalTicks,
    output logic [N-1:0] count
    );
    
    parameter ZERO={N{1'b0}};
    
    logic [N-1:0] counter, n_counter;
    
    always_ff @(posedge clk, posedge rst)
    begin
    if (rst)
        begin
            counter<=ZERO;
            totalTicks<=0;
        end
    else
        counter<=n_counter;
        
    if (count == 99999) 
        begin
        tick <= 1;   // Output tick for 1 clock cycle (1ms)
        count <= 0;     // Reset the counter
        totalTicks <= totalTicks + 1;
        end 
    else 
        begin
            tick <= 0;   // Output low
        end
    end
        
    always_comb
        if(en)
            if(up)
                n_counter = counter + 1;
            else
                n_counter = counter - 1;
        else
            n_counter = counter;        
        
    assign count = counter;
endmodule
