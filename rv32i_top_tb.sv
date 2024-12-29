`timescale 1ns / 1ps
module rv32i_top_tb;

        parameter n = 32, depth = 1024;
                
        logic clk;
        logic reset_n;
        
        rv32i_top #( n , depth )
                cpu (
                    .clk(clk),
                    .reset_n(reset_n)      
                );
                
        initial begin
            clk = 0;
            reset_n = 0;
            #2 reset_n =1;
            #100 $finish;
        end
         always #5 clk = ~clk;
        
        
endmodule