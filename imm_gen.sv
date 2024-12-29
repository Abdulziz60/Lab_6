`timescale 1ns / 1ps

module imm_gen(
    input  logic [31:0] inst,
    output logic [31:0] imm 
    );
    
       
    logic [6:0] opcode;
    assign opcode = inst[6:0]; 
    
    always_comb begin
    case ( opcode )
        // I-type    
        7'b0010011 : imm = {{20{inst[31]}}, inst[31:20]}; 
        
        // S-type    
        7'b0100011 : imm = {{20{inst[31]}}, inst[31:25], inst[11:7]} ; 
           
        // B-type    
        7'b1100011 : imm = {{20{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8]} ;    
        
        
        default : imm = 32'bx ;
    endcase
end    
endmodule
