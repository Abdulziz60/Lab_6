`timescale 1ns / 1ps


module inst_mem_tb ;

 logic [31:0]address;
 logic [31:0]instruction;
    
  inst_mem DUT(
  .address(address),
  .instruction(instruction)
  );  
    
    logic [255:0]memory [0:31];
    
    initial begin
    $readmemb("/home/it/Computer_Architecture/cx-204/Lab_1/CX-204-Lab1/support_files/fib_im.mem", memory);
    end
    
    
   initial begin

address = 'b0000; #10;
address = 'b0001; #10;
address = 'b0010; #10;
address = 'b0011; #10;



$finish;
end
endmodule