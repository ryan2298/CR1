`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 05:03:50 PM
// Design Name: 
// Module Name: decoder
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


module decoder(
input logic [3:0] code,
output logic [7:0] an,
output logic [7:0] sseg);

always_comb
        case(code)
            4'b0000:
                begin
                    an = 8'b01111111;
                    sseg = 8'b10011100; //top-half
                end
            4'b0001:
                begin
                    an = 8'b10111111;
                    sseg = 8'b10011100;
                end
            4'b0010:
                begin
                    an = 8'b11011111;
                    sseg = 8'b10011100;
                end
            4'b0011:
                begin
                    an = 8'b11101111;
                    sseg = 8'b10011100;
                end
            4'b0100:
                begin
                    an = 8'b11110111;
                     sseg = 8'b10011100;
                end
            4'b0101:
                begin
                    an = 8'b11111011;
                    sseg = 8'b10011100;
                end
            4'b0110:
                begin
                    an = 8'b11111101;
                    sseg = 8'b10011100;
                end
            4'b0111:
                begin
                    an = 8'b11111110;
                    sseg = 8'b10011100; //top
                end
            4'b1000:
                begin
                    an = 8'b11111110;
                    sseg = 8'b10100011; //bot
                end
            4'b1001:
                begin
                    an = 8'b11111101;
                    sseg = 8'b10100011; //bottom-half
                end
            4'b1010:
                begin
                    an = 8'b11111011;
                    sseg = 8'b10100011; //bottom-half
                end
            4'b1011:
                begin
                    an = 8'b11110111;
                    sseg = 8'b10100011; //bottom-half
                end
            4'b1100:
                begin
                    an = 8'b11101111;
                    sseg = 8'b10100011; //bottom-half
                end
            4'b1101:
                begin
                    an = 8'b11011111;
                    sseg = 8'b10100011; //bottom-half
                end
            4'b1110:
                begin
                    an = 8'b10111111;
                    sseg = 8'b10100011; //bottom-half
                end
            4'b1111:
                begin
                    an = 8'b01111111;
                    sseg = 8'b10100011; //bottom-half
                end
            default:
                begin
                    an = 8'b1111;
                    sseg = 8'b11100010; //bottom-half
                end
            endcase
endmodule
