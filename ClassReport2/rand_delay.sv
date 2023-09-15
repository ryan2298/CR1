`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 01:32:22 PM
// Design Name: 
// Module Name: rand_delay
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

module rand_delay(
    input logic clk,
    input logic rst,
    input logic en,
    output logic out
    );
    
   logic [3:0] delayCounter;
   
   localparam [1:0] IDLE = 2'b00;
   localparam [1:0] COUNT = 2'b01;
   localparam [1:0] FINISH = 2'b10;
   
   logic [1:0] state;
   logic [31:0] clockCounter;

   always @(posedge clk or posedge rst) begin
       if (rst) begin
            state <= IDLE;
            delayCounter <= 0;
            out <= 0;
            clockCounter <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (en) begin
                    delayCounter <= $random %14 + 2;
                    state <= COUNT;
                    end
                end
                COUNT: begin
                    if (en && clockCounter >= (delayCounter * 100000000)) begin
                        state <= FINISH;
                    end else if (!en) begin
                        state <= IDLE;    
                    end
                    else begin
                        clockCounter <= clockCounter + 1;
                    end
                end
                FINISH: begin
                    out <= 1;
                    state <= IDLE;
                    clockCounter <= 0;
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
