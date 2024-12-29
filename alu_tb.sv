`timescale 1ns / 1ps


module alu_tb;
    logic [31:0] op1;              
    logic [31:0] op2;              
    logic [3:0] alu_ctrl;          
                             
    logic [31:0] alu_result;
    logic zero;              

alu compute (
    .op1(op1),
    .op2(op2),
    .alu_ctrl(alu_ctrl),
    .alu_result(alu_result),
    .zero(zero)
    );

initial begin

   op1= 'b01110101 ;
   op2= 'b00111001 ;
   alu_ctrl= 4'b0000 ; 
#5
   alu_ctrl= 4'b1000 ; 
#5
   alu_ctrl= 4'b0001 ; 
#5
   alu_ctrl= 4'b0010 ; 
#5   
    alu_ctrl= 4'b0011 ; 
#5
   alu_ctrl= 4'b0100 ; 
#5
   alu_ctrl= 4'b0101 ; 
#5
   alu_ctrl= 4'b1101 ; 
#5
   alu_ctrl= 4'b0110 ; 
#5
   alu_ctrl= 4'b0111 ; 
#5
    op1= 'b0 ;
    op2= 'b0 ;    
#20
$finish;
end
endmodule