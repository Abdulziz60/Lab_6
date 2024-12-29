`timescale 1ns / 1ps

module alu_control(
    input logic  [1:0]alu_op,
    input logic  [31:0]inst,
    output logic [3:0]alu_ctrl
    );
    logic [2:0]func3;
    logic [6:0]func7;
    
    assign func3 = inst[14:12];
    assign func7 = inst[31:20];
    
    always_comb begin
        case (alu_op)
            //Load & Store
            2'b00: begin
                alu_ctrl = 4'b0000;  
            end
            //beq
            2'b01: begin
                alu_ctrl = 4'b1000;  
            end
            //R-type
            2'b10: begin
                alu_ctrl = {func7[5],func3[2:0]};
             end
             //I-type
             2'b11: begin
                    alu_ctrl = {1'b0,func3[2:0]};
             end   
               default: alu_ctrl = 4'bx;       
        endcase
    end        
endmodule
