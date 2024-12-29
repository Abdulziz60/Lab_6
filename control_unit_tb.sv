`timescale 1ns / 1ps

module control_unit_tb;

    // Inputs
    reg clk;
    reg reset_n;

    // Outputs
    wire branch;
    wire mem_write;
    wire mem_to_reg;
    wire mem_read;
    wire alu_src;
    wire reg_write;
    wire [3:0] alu_ctrl;

    // Instantiate the control unit module
    control_unit dut (
        .inst(dut.inst_mem_inst.memory), // Connect the instruction memory of the DUT
        .branch(branch),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_ctrl(alu_ctrl)
    );

    // Test process
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        
        // Apply reset
        reset_n = 0;
        #5 reset_n = 1;
        
        // Load instruction memory from the file
        $readmemh("/home/it/Computer_Architecture/cx-204/sample1.hex", dut.inst_mem_inst.memory);
        
        // Test with a few clock cycles
        #10;
        
        // Display the control signals after the first instruction
        $display("Test 1: First Instruction");
        $display("branch = %b, mem_write = %b, mem_to_reg = %b, mem_read = %b, alu_src = %b, reg_write = %b, alu_ctrl = %b", 
                 branch, mem_write, mem_to_reg, mem_read, alu_src, reg_write, alu_ctrl);
        
        // Continue testing through the instructions
        // Add more test cases by cycling through the clock or checking for different instructions from the memory

        // End the simulation after a few cycles
        $finish;
    end
    
    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5ns
    end

endmodule
