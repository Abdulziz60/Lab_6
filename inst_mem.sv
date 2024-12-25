`timescale 1ns / 1ps

module inst_mem #( 
    parameter WIDTH = 32,
    parameter DEPTH = 256 ) (
    input  logic clk,
    input  logic [WIDTH - 1 :0] address, 
    output logic [WIDTH - 1 :0] instruction    
    );
    
    logic [WIDTH - 1 :0] memory [ 0 : DEPTH - 1];
    
    initial begin 
        $readmemh("home/it/machine.hex",memory);
    end 
    
    assign instruction = memory[address[WIDTH - 1 :0]];
    
endmodule
