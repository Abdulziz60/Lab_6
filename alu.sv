`timescale 1ns / 1ps

module alu #( parameter ALU_WIDTH = 32 ) (
    input  logic [ALU_WIDTH - 1 : 0 ] op1, op2 ,
    input  logic [ 3 : 0 ] alu_ctrl , //selcter 
    output logic [ALU_WIDTH - 1 : 0 ] alu_result,
    output logic Zero
    );
    
    always_comb begin
    case (alu_ctrl) 
        4'b0000 : alu_result = op1 + op2 ; //addition
        4'b1000 : alu_result = op1 - op2 ; //subtraction
        4'b0111 : alu_result = op1 & op2 ; //AND
        4'b0110 : alu_result = op1 | op2 ; //OR 
        4'b0001 : alu_result = op1 << op2; //SLL
        4'b0010 : alu_result = op1 < op2 ; 
        
        default : alu_result = 32'b0;
        
        
    endcase
    end
endmodule
