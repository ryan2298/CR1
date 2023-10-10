module counter_timer #(parameter N=20)(
    input logic clk,
    input logic rst,
    input logic up,
    input logic en,
    output logic tic,
    output logic [N-1:0] count
    );
    
    parameter ZERO={N,{1'b0}};
    logic [N-1:0] counter, n_counter;
    
    always_ff @(posedge clk, posedge rst)
    if (rst)
        begin
        counter<=ZERO;
        end
    else 
        counter<=n_counter;
    
    always_comb
        if(en)
        begin
            if(counter == 17'd100000)
                n_counter = 0;
            else if(up)
                n_counter = counter + 1;
            else
                n_counter = counter - 1;
        end
        else
            n_counter = counter;
    assign count = counter;
    assign tic=counter==17'd100000;
    
endmodule