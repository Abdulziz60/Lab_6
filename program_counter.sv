`timescale 1ns / 1ps


module program_counter #( parameter PROG_VALUE = 32 ) (
    input  logic clk,reset_n,
    input  logic [PROG_VALUE - 1 : 0 ] data_in  ,
    output logic [PROG_VALUE - 1 : 0 ] data_out 
    
    );
    
    always @ ( posedge clk , negedge reset_n )
    if (~reset_n) begin 
        data_out <= 0;
    end 
    else begin 
        data_out <= data_in;
    end     
endmodule
