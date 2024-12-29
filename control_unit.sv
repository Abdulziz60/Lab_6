module control_unit #(parameter WIDTH = 32)
    (
    input logic [ WIDTH - 1 : 0 ] inst,
    output logic reg_write,
    output logic mem_write,
    output logic mem_to_reg,
    output logic alu_src,
    output logic branch,
    output logic [3:0] alu_ctrl
);

    logic [1:0] alu_op;

    main_control mc(
                .opcode(inst[6:0]),
                .reg_write(reg_write),
                .mem_write(mem_write),
                .mem_to_reg(mem_to_reg),
                .alu_op(alu_op),
                .alu_src(alu_src),
                .branch(branch)
    );
    
    alu_control #(WIDTH) aluctrl(
                .inst(inst),
                .alu_op(alu_op),
                .alu_ctrl(alu_ctrl)
    );

endmodule