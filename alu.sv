`timescale 1ns / 1ps

module alu #( parameter ALU_WIDTH = 32 ) (
    input  logic [ALU_WIDTH - 1 : 0 ] op1, op2 ,
    input  logic [ 3 : 0 ] alu_ctrl , //selcter 
    output logic [ALU_WIDTH - 1 : 0 ] alu_result,
    output logic zero
    );
    
    always_comb begin
    case (alu_ctrl) 
        4'b0000 : alu_result = op1 + op2 ; //add
        4'b1000 : alu_result = op1 - op2 ; //sub
        4'b0111 : alu_result = op1 & op2 ; //AND
        4'b0110 : alu_result = op1 | op2 ; //OR 
        4'b0100 : alu_result = op1 ^ op2 ; //XOR
        4'b0001 : alu_result = op1 << op2; //SLL
        4'b0101 : alu_result = op1 >> op2 ;//SRL 
        4'b1101 : alu_result = $signed(op1) >>> $signed (op2) ;//SRA 
        4'b0010 : alu_result = $signed(op1) < $signed(op2)? 1 : 0 ; //SLT
        4'b0011 : alu_result = (op1 < op2) ? 1 : 0 ; //SLTU
        
        default : alu_result = 32'bx;
    endcase    
        
     zero = (alu_result == 0 )? 1'b1 : 1'b0;   
    
    end
endmodule
