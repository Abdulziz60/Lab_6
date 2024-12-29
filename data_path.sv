module data_path#(parameter n = 32, depth = 1024)
                (
                    input logic clk,
                    input logic reset_n,
                    input logic branch,
                    input logic ALUsrc,
                    input logic memToReg,
                    input logic mem_write,
                    input logic reg_write,
                    input logic [3:0] alu_ctrl,
                    output logic [n-1:0] inst 
                );


    logic [n-1:0] data_o;
    logic [$clog2(depth)-1:0] addr;
    logic [n-1:0] rdata;
    logic [n-1:0] imm;
    logic [$clog2(n)-1:0] raddr1; 
    logic [$clog2(n)-1:0] raddr2; 
    logic [$clog2(n)-1:0] waddr;
    logic [n-1:0] rdata1;
    logic [n-1:0] rdata2;
    logic [n-1:0] alu_result;
    logic [n-1:0] mux_output1;
    logic [n-1:0] mux_output2;
    logic [n-1:0] mux_output3;   
    logic PCsrc;            
    logic zero;
    
    
    assign PCsrc = zero & branch;
    assign raddr1 = inst[19:15];
    assign raddr2 = inst[24:20];
    assign waddr = inst[11:7];
    assign mux_output1 = (ALUsrc)? imm: rdata2;
    assign mux_output2 = (memToReg)? rdata: alu_result;
    assign mux_output3 = (PCsrc)? data_o + imm: data_o + 4;

    
    inst_mem # (n) rom(
                 .address(data_o),
                 .instruction(inst)
                );
                
    data_mem #(n) d(
    .clk(clk),
    .reset_n(reset_n),
    .mem_write(mem_write),
    .addr(alu_result),
    .wdata(rdata2),
    .rdata(rdata)
    );

    imm_gen #(n) i(
     .inst(inst),
     .imm(imm)
    );

    reg_file #(n) f(
    .clk(clk),
    .reset_n(reset_n),
    .reg_write(reg_write),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .waddr(waddr),
    .wdata(mux_output2),
    .rdata1(rdata1),
    .rdata2(rdata2)
    );

    alu #(n) u(
    .op1(rdata1),
    .op2(mux_output1),
    .alu_ctrl(alu_ctrl),
    .alu_result(alu_result),
    .zero(zero)
    );

    program_counter #(n) p(
    .clk(clk),
    .reset_n(reset_n),
    .data_in(mux_output3),
    .data_o(data_o)
    );
    

endmodule