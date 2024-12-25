`timescale 1ns / 1ps


module reg_file(
input logic clk, reset_n, reg_write,
input logic [4:0]raddr1, raddr2, waddr,
input logic [31:0]wdata, 
output logic [31:0]rdata1, rdata2
    );
    
    logic [31:0] file [0:31];
    
    
    assign rdata1 = (raddr1 == 5'b00000) ? '0 : file [raddr1];
    assign rdata2 = (raddr2 == 5'b00000) ? '0 : file [raddr2];
//    assign wdata  = (waddr  == 5'b00000) ? 0 : file [waddr]; because its wrong
    
    
    always_ff @ (posedge clk, negedge reset_n) begin
        if (reset_n == 0) begin
            file[0] <= '0;
            file[1] <= '0;
            file[2] <= '0;
            file[3] <= '0;
            file[4] <= '0;
            file[5] <= '0;
            file[6] <= '0;
            file[7] <= '0;
            file[8] <= '0;
            file[9] <= '0;
            file[10] <= '0;
            file[11] <= '0;
            file[12] <= '0;
            file[13] <= '0;
            file[14] <= '0;
            file[15] <= '0;
            file[16] <= '0;
            file[17] <= '0;
            file[18] <= '0;
            file[19] <= '0;
            file[20] <= '0;
            file[21] <= '0;
            file[22] <= '0;
            file[23] <= '0;
            file[24] <= '0;
            file[25] <= '0;
            file[26] <= '0;
            file[27] <= '0;
            file[28] <= '0;
            file[29] <= '0;
            file[30] <= '0;
            file[31] <= '0;
        end
        else if (reg_write) begin
            file[waddr] <= wdata;
            file[0] <= '0;
            

        end
        else
         file[waddr] <= file[waddr];
    end
    
    
    
    
    
endmodule