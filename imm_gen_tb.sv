module imm_gen_tb;

    logic [31:0] inst;
    logic [31:0] imm;

   
    imm_gen imm_gen_inst (
        .inst(inst),
        .imm(imm)
    );

   
    initial begin
        inst = 32'b000000000001_00000_000_00001_0010011; // addi x1, x0, 1
        #10;
        $display("I-type: inst = %h, imm = %h", inst, imm);

        // S-type
        inst = 32'b0000000_00001_00010_010_00011_0100011; // sw x1, 3(x2)
        #10;
        $display("S-type: inst = %h, imm = %h", inst, imm);

        //B-type
        inst = 32'b0000000_00001_00010_000_00001_1100011; // beq x1, x2, 2
        #10;
        $display("B-type: inst = %h, imm = %h", inst, imm);

        $finish;
    end

endmodule
