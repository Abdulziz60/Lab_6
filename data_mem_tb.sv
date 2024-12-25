`timescale 1ns / 1ps

module data_mem_tb;

    logic clk;        
    logic reset_n;        
    logic mem_write;        
    logic [31:0] addr; 
    logic [31:0] wdata;
    logic [31:0] rdata; 
    
    data_mem DUTdatamemo(
    .clk(clk), 
    .reset_n(reset_n), 
    .mem_write(mem_write),
    .addr(addr), 
    .wdata(wdata), 
    .rdata(rdata)
    
    );
    
    initial clk=0; 
    always #5 clk = ~clk;
   
    initial begin
    reset_n = 0;#2;
    reset_n = 1;
    
    mem_write = 1; 
    addr = 32'h00000000; wdata = 32'hAADDEEFF;#10;
    addr = 32'h00000004; wdata = 32'hFFEEDDAA;#10;
    
    mem_write = 0; 
    addr = 32'h00000000;#10;
    addr = 32'h00000004;#10;
    
    reset_n = 0;
    addr = 32'h00000000;#10;
    addr = 32'h00000004;#10;
    
    $finish;
    end
  
endmodule
