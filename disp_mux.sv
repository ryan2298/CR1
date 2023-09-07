`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 09:15:39 AM
// Design Name: 
// Module Name: disp_mux
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


module disp_mux(
    input logic clk,
    input logic reset,
    input logic [7:0] in3,
    input logic [7:0] in2, 
    input logic [7:0] in1, 
    input logic [7:0] in0, 
    output logic [7:0] an,
    output logic [7:0] sseg //led segments
    );
    
    localparam N = 18;
    
    logic [N-1:0] q_reg;
    logic [N-1:0] q_next;
    
    always_ff @(posedge clk, posedge reset)
        if (reset)
            q_reg <= 0;
        else
            q_reg <= q_next;
            
    assign q_next = q_reg + 1;
    
    always_comb
        case (q_reg[N-1:N-2])
            2'b00:
                begin
                    an = 4'b1110; //powers the sseg
                    sseg = in0; //specific pattern
                end
            2'b01:
                begin
                    an = 4'b1101;
                    sseg = in1;
                end
            2'b10:
                begin
                    an = 4'b1011;
                    sseg = in2;
                end
            default:
                begin
                    an = 4'b0111;
                    sseg = in3;
                end
        endcase
        
        assign an[7:4] = 4'b1111;
        
        //^generates control signal to multiplexer
endmodule
