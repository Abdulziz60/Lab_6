`timescale 1ns / 1ps


module data_mem #( parameter DATA_MEM_WIDTH = 32 )(
    input  logic clk, reset_n, mem_write,
    input  logic [DATA_MEM_WIDTH - 1 : 0 ] addr, 
    input  logic [DATA_MEM_WIDTH - 1 : 0 ] wdata, 
    output logic [DATA_MEM_WIDTH - 1 : 0 ] rdata
    
    );
    
    logic [31:0] demo[0:1023];
    
    always_ff @ ( posedge clk , negedge reset_n ) begin 
    
        if (~reset_n) begin
            integer i;
            for (i=0 ; i<1023 ; i = i+1) begin
                demo[i] <= {DATA_MEM_WIDTH - 1 {1'b0}};
                rdata <= 0;
            end
        end else 
            if ( mem_write ) begin 
               demo[addr[DATA_MEM_WIDTH - 1 : 2 ] ] <= wdata; 
            end else begin
                rdata <= demo[addr[DATA_MEM_WIDTH - 1 : 2 ] ];
            end
        
        end 
    
endmodule
