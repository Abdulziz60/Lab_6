`timescale 1ns / 1ps


module reg_file#( parameter REGF_WIDTH = 32 )(
    input clk,
    input reset_n,
    input reg_write,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [REGF_WIDTH-1:0] wdata,
    output logic [REGF_WIDTH - 1 : 0] rdata1,
    output logic [REGF_WIDTH - 1 : 0] rdata2
);
    logic [REGF_WIDTH -1:0] register_file [REGF_WIDTH -1:0];

    initial register_file[0] = '0;
    logic [REGF_WIDTH-1:0] i;

    always_ff @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin 
           for(i = 1; i < REGF_WIDTH; i = i + 1)
            register_file[i] <= '0;
        end
        else if (reg_write & (waddr !=0)) begin
        register_file[waddr] <= wdata;
        end
    end

    assign rdata1 = register_file[raddr1];
    assign rdata2 = register_file[raddr2];

endmodule