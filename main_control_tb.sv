`timescale 1ns / 1ps

module main_control_tb;

    // Parameters
    reg [6:0] opcode;
    wire branch, mem_write, mem_to_reg, alu_src;
    wire [1:0] alu_op;
    wire reg_write;

    // Instantiate the design under test (DUT)
    main_control dut (
        .opcode(opcode),
        .branch(branch),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .reg_write(reg_write)
    );

    // Memory array to store instructions from the file
    reg [6:0] instructions [0:255];  // Assuming the file has 256 instructions

    // Test process
    initial begin
        // Load instructions from the hex file into the instruction memory
        $readmemh("/home/it/Computer_Architecture/cx-204/sample1.hex", instructions);

        // Apply each instruction to the DUT
        for (integer i = 0; i < 256; i = i + 1) begin
            // Set opcode from the instruction memory
            opcode = instructions[i];
            
            // Wait for some time to let the signals settle
            #10;
            
            // Display the results for this opcode
            $display("Test %0d: opcode = %b", i, opcode);
            $display("branch = %b, mem_write = %b, mem_to_reg = %b, alu_op = %b, alu_src = %b, reg_write = %b", 
                     branch, mem_write, mem_to_reg, alu_op, alu_src, reg_write);
        end

        // End of test
        $finish;
    end

endmodule
