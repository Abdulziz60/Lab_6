`timescale 1ns / 1ps

module inst_mem #
     (parameter n = 32)
     (
      input logic [n-1:0] address,
      output logic [n-1:0] instruction
     );
     
     logic [31:0] memory [0:255];
                
   initial
    
    $readmemh("/home/it/Computer_Architecture/cx-204/sample1.hex",memory);
   
    
    assign instruction = memory[address >> 2];
    
endmodule
