`timescale 1ns / 1ps

module data_path(
    input logic clk, reset_n 
    );
    
    logic [31:0] next_pc;
    logic [31:0] data_out;
    logic [31:0] inst;
    logic [4:0]reg_raddr1;
    logic [4:0]reg_raddr2;
    logic [31:0] alu_result;
    logic [3 :0]alu_ctrl;
    logic Zero;
    logic [31:0]reg_wdata;
    logic reg_wirte;
    logic [4:0]rs1;
    logic [4:0]rs2;
    logic [4:0]rd;
    logic [31:0]imm;
    logic [31:0]mem_rdata;
    logic memtoreg;
    logic [31:0]reg_rdadt1;
    logic [31:0]reg_rdadt2;
    logic [31:0]current_pc;
    logic pc_sel;
    logic branch;
    logic [31:0]alu_op2;
    logic alu_src;
    logic mem_write;
    
    //ALU1 from PC
    logic pc_plus_4 ; 
    logic pc_jump;
    //ALU1 from PC
    assign pc_plus_4 = data_out + 4 ;
    assign pc_jump = current_pc + imm;
    
    assign reg_wdata = (memtoreg) ? mem_rdata : alu_result ;
    assign pc_sel = branch & Zero;
    assign next_pc = (pc_sel) ? pc_jump : pc_plus_4 ;
    assign alu_op2 = (alu_src)? imm : reg_rdadt2;
    
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd  = inst[11:7]; 
    
    program_counter #( .PROG_VALUE (32) ) pc_inst (
    .clk(clk),
    .reset_n(reset_n),
    .data_in(next_pc),
    .data_out(current_pc) 
    
    );
    
     
    
    inst_mem #( .WIDTH (32), .DEPTH (256) ) inst_mem_inst (
    .clk(clk),
    .address(current_pc), 
    .instruction(inst)    
    );
    
    reg_file reg_file_inst (
    .clk(clk), 
    .reset_n(reset_n), 
    .reg_write(reg_wirte),
    .raddr1(rs1), 
    .raddr2(rs2), 
    .waddr(rd),
    .wdata(reg_wdata), 
    .rdata1(reg_rdadt1), 
    .rdata2(reg_rdadt2)
    );
    
    imm_gen imm_gen_inst (
    .inst(inst),
    .imm(imm)
    );
    
    alu #( .ALU_WIDTH (32) ) alu_inst (
    .op1(reg_raddr1), 
    .op2(alu_op2),
    .alu_ctrl(alu_ctrl), //selcter 
    .alu_result(alu_result),
    .Zero(Zero)
    );
    
    
    
    data_mem #( .DATA_MEM_WIDTH (32) ) data_mem_inst (
    .clk(clk), 
    .reset_n(reset_n), 
    .mem_write(mem_write),
    .addr(alu_result), 
    .wdata(reg_rdadt2), 
    .rdata(mem_rdata)
    
    );
    
    
endmodule
