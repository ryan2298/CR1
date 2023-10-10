`timescale 1ns / 1ps

module sseg_decoder (
    input logic tic_ms,
    input logic [1:0] state_system,
    input logic rst,
    input logic [11:0] bcd, 
    output logic [7:0] sseg,
    output logic [3:0] an
);
    
    parameter firstPass = 0;
    parameter secondPass = 1;
    parameter thirdPass = 2;
    parameter fourthPass = 3;
    parameter IDLE = 2'b00;

    logic [2:0] state, n_state;

    always_ff @(posedge tic_ms, posedge rst) begin
        if(rst)
            state <= 0;
        else begin
            state = n_state;
        end
    end
    
    always_comb begin
        if(state_system != IDLE)
            begin
            case(state)
                firstPass: begin	
                    case(bcd[3:0])
                        4'b0000: begin
                            sseg = 8'b11000000; //0
                            an = 4'b1110;
                        end
                        4'b0001: begin
                            sseg = 8'b11111001; //1
                            an = 4'b1110;
                        end
                        4'b0010: begin
                            sseg = 8'b10100100; //2
                            an = 4'b1110;
                        end
                        4'b0011: begin
                            sseg = 8'b10110000; //3
                            an = 4'b1110;
                        end
                        4'b0100: begin
                            sseg = 8'b10011001; //4
                            an = 4'b1110;
                        end
                        4'b0101: begin
                            sseg = 8'b10010010; //5
                            an = 4'b1110;
                        end
                        4'b0110: begin
                            sseg = 8'b10000010; //6
                            an = 4'b1110;
                        end
                        4'b0111: begin
                            sseg = 8'b11111000; //7
                            an = 4'b1110;
                        end
                        4'b1000: begin
                            sseg = 8'b10000000; //8
                            an = 4'b1110;
                        end
                        4'b1001: begin
                            sseg = 8'b10011000; //9
                            an = 4'b1110;
                        end
                        4'b1111: begin
                            sseg = 8'b10011000; //9
                            an = 4'b1110;
                        end
                    endcase
                    n_state = secondPass;
                end
                secondPass: begin
                    case(bcd[7:4])
                        4'b0000: begin
                            sseg = 8'b11000000; //0
                            an = 4'b1101;
                        end
                        4'b0001: begin
                            sseg = 8'b11111001; //1
                            an = 4'b1101;
                        end
                        4'b0010: begin
                            sseg = 8'b10100100; //2
                            an = 4'b1101;
                        end
                        4'b0011: begin
                            sseg = 8'b10110000; //3
                            an = 4'b1101;
                        end
                        4'b0100: begin
                            sseg = 8'b10011001; //4
                            an = 4'b1101;
                        end
                        4'b0101: begin
                            sseg = 8'b10010010; //5
                            an = 4'b1101;
                        end
                        4'b0110: begin
                            sseg = 8'b10000010; //6
                            an = 4'b1101;
                        end
                        4'b0111: begin
                            sseg = 8'b11111000; //7
                            an = 4'b1101;
                        end
                        4'b1000: begin
                            sseg = 8'b10000000; //8
                            an = 4'b1101;
                        end
                        4'b1001: begin
                            sseg = 8'b10011000; //9
                            an = 4'b1101;
                        end
                        4'b1111: begin
                            sseg = 8'b10011000; //9
                            an = 4'b1101;
                        end
                    endcase
                    n_state = thirdPass;
                end
                thirdPass: begin
                    case(bcd[11:8])
                        4'b0000: begin
                            sseg = 8'b11000000; //0
                            an = 4'b1011;
                        end
                        4'b0001: begin
                            sseg = 8'b11111001; //1
                            an = 4'b1011;
                        end
                        4'b0010: begin
                            sseg = 8'b10100100; //2
                            an = 4'b1011;
                        end
                        4'b0011: begin
                            sseg = 8'b10110000; //3
                            an = 4'b1011;
                        end
                        4'b0100: begin
                            sseg = 8'b10011001; //4
                            an = 4'b1011;
                        end
                        4'b0101: begin
                            sseg = 8'b10010010; //5
                            an = 4'b1011;
                        end
                        4'b0110: begin
                            sseg = 8'b10000010; //6
                            an = 4'b1011;
                        end
                        4'b0111: begin
                            sseg = 8'b11111000; //7
                            an = 4'b1011;
                        end
                        4'b1000: begin
                            sseg = 8'b10000000; //8
                            an = 4'b1011;
                        end
                        4'b1001: begin
                            sseg = 8'b10011000; //9
                            an = 4'b1011;
                        end
                        4'b1111: begin
                            sseg = 8'b10011000; //9
                            an = 4'b1011;
                        end
                    endcase
                    n_state = fourthPass ;
                end
                fourthPass: begin
                    case(bcd[11:0])
                        12'b111111111111: begin
                            sseg = 8'b10011000; //9
                            an = 4'b0111;
                        end
                        default: begin
                            sseg = 8'b11000000; //0
                            an = 4'b0111;
                        end
                    endcase
                    n_state = firstPass;
                end
            endcase
	    end
	    
	    else
	    begin
	    case(state)
                firstPass: begin	
                    n_state = secondPass;
                    sseg = 8'b11001111; //0
                    an = 4'b1110;
                end
                secondPass: begin
                    n_state = firstPass;
                    sseg = 8'b10001001; //0
                    an = 4'b1101;
                end
                thirdPass: begin
                    n_state = firstPass;
                end
                fourthPass: begin
                    n_state = firstPass;
                end
            endcase
	    end
    end
endmodule

