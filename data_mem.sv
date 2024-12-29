`timescale 1ns / 1ps


module data_mem #( parameter DATA_MEM_WIDTH = 32 )(
    input  logic clk, reset_n, mem_write,
    input  logic [DATA_MEM_WIDTH - 1 : 0 ] addr, 
    input  logic [DATA_MEM_WIDTH - 1 : 0 ] wdata, 
    output logic [DATA_MEM_WIDTH - 1 : 0 ] rdata
    
    );
    
    logic [31:0] dmem[0:1023];
    
    always @ ( posedge clk , negedge reset_n ) begin 
    
        if (~reset_n) begin
            integer i;
            for (i=0 ; i<1023 ; i = i+1) begin
                dmem[i] <= 0;
            end
        end else 
            if ( mem_write ) begin 
                dmem [addr] <= wdata;  
            end 
          end       
           
            assign rdata = dmem[addr];
            
         
    
endmodule
