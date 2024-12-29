`timescale 1ns / 1ps
module rv32i_top #(parameter n = 32, depth = 1024)
                (
                input logic clk,
                input logic reset_n      
                );
    
    
                 logic branch;
                 logic ALUsrc;
                 logic memToReg;
                 logic mem_write;
                 logic reg_write;
                 logic [3:0] alu_ctrl;
                 logic [n-1:0] inst;
                 logic [1:0] ALUOp;
                 
    data_path#(n , depth)
                dp(
                    .clk(clk),
                    .reset_n(reset_n),
                    .branch(branch),
                    .ALUsrc(ALUsrc),
                    .memToReg(memToReg),
                    .mem_write(mem_write),
                    .reg_write(reg_write),
                    .alu_ctrl(alu_ctrl),
                    .inst(inst)
                );
    
    control_unit #( n )cu(
                .inst(inst),
                .reg_write(reg_write),
                .mem_write(mem_write),
                .mem_to_reg(memToReg),
                .alu_src(ALUsrc),
                .branch(branch),
                .alu_ctrl(alu_ctrl)
    );


endmodule
