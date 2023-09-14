`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2023 07:43:19 PM
// Design Name: 
// Module Name: sseg_decoder
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

module sseg_decoder (
    input logic [11:0] code,     // 4-bit binary input
    output logic [7:0] sseg,              // Seven-segment display output
    output logic [3:0] an
);
            
    always_comb
        case(code[3:0])
            4'b0000:
                begin
                    sseg = 8'b11000000; //0
                end
            4'b0001:
                begin
                    sseg = 8'b11111001; //1
                end
            4'b0010:
                begin
                    sseg = 8'b10100100; //2
                end
            4'b0011:
                begin
                    sseg = 8'b10110000; //3
                end
            4'b0100:
                begin
                     sseg = 8'b10011001; //4
                end
            4'b0101:
                begin
                    sseg = 8'b10010010; //5
                end
            4'b0110:
                begin
                    sseg = 8'b10000010; //6
                end
            4'b0111:
                begin
                    sseg = 8'b11111000; //7
                end
            4'b1000:
                begin
                    sseg = 8'b100000000; //8
                end
            4'b1001:
                begin
                    sseg = 8'b10011000; //9
                end
            default:
                begin
                    sseg = 8'b00000000;
                end
        endcase
        
        always_comb
        case(code[7:4])
            4'b0000:
                begin
                    sseg = 8'b11000000; //0
                end
            4'b0001:
                begin
                    sseg = 8'b11111001; //1
                end
            4'b0010:
                begin
                    sseg = 8'b10100100; //2
                end
            4'b0011:
                begin
                    sseg = 8'b10110000; //3
                end
            4'b0100:
                begin
                     sseg = 8'b10011001; //4
                end
            4'b0101:
                begin
                    sseg = 8'b10010010; //5
                end
            4'b0110:
                begin
                    sseg = 8'b10000010; //6
                end
            4'b0111:
                begin
                    sseg = 8'b11111000; //7
                end
            4'b1000:
                begin
                    sseg = 8'b100000000; //8
                end
            4'b1001:
                begin
                    sseg = 8'b10011000; //9
                end
            default:
                begin
                    sseg = 8'b00000000;
                end
        endcase
        
        always_comb
        case(code[9:8])
            2'b00:
                begin
                    sseg = 8'b11000000; //0
                end
            2'b01:
                begin
                    sseg = 8'b11111001; //1
                end
            default:
                begin
                    sseg = 8'b0000000;
                end
        endcase
            
        if(code < 10)
            assign an = 4'b1110;
        else if(code < 100)
            assign an = 4'b1100;
        else if(code < 1000)
            assign an = 4'b1000;
        else
            assign an = 4'b0000;
endmodule

