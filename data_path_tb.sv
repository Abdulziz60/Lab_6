`timescale 1ns / 1ps

module data_path_tb;

    `timescale 1ns / 1ps


    // Parameters
    parameter WIDTH = 32;
    parameter DEPTH = 1024;

    // Signals
    logic clk;
    logic reset_n;
    logic branch;
    logic mem_write;
    logic mem_to_reg;
    logic alu_ctrl;
    logic alu_src;
    logic [1:0] alu_op;
    logic reg_write;
    
    // Instantiate the design under test (DUT)
    data_path #(WIDTH, DEPTH) dut (
        .clk(clk),
        .reset_n(reset_n),
        .branch(branch),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .reg_write(reg_write)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Memory loading - File path for hex data
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        branch = 0;
        mem_write = 0;
        mem_to_reg = 0;
        alu_ctrl = 0;
        alu_src = 0;
        alu_op = 2'b00;
        reg_write = 0;

        // Apply reset
        #10;
        reset_n = 1;
        #10;

        // Load instruction memory from a file
        $readmemh("/home/it/Computer_Architecture/cx-204/sample1.hex", dut.inst_mem_inst.memory);
        $display("Memory loaded from /home/it/Computer_Architecture/cx-204/sample1.hex");

        // Test 1: ALU operation
        $display("Test 1: ALU operation");
        reg_write = 1;
        alu_ctrl = 1;  // Example ALU control signal (you can modify for different operations)
        alu_src = 0;
        alu_op = 2'b01; // ALU operation
        #10;
        $display("ALU result: %h", dut.alu_result);
        
        // Test 2: Branch operation
        $display("Test 2: Branch operation");
        branch = 1;
        reg_write = 1;
        #10;
        $display("Branch taken, next PC: %h", dut.next_pc);
        
        // Test 3: Memory write operation
        $display("Test 3: Memory write operation");
        mem_write = 1;
        reg_write = 0;
        #10;
        $display("Data written to memory address: %h", dut.alu_result);
        
        // Test 4: Memory read to register (mem_to_reg)
        $display("Test 4: Memory read to register");
        mem_write = 0;
        mem_to_reg = 1;
        reg_write = 1;
        #10;
        $display("Data written to register: %h", dut.reg_wdata);
        
        // Test 5: Reset operation
        $display("Test 5: Reset operation");
        reset_n = 0;  // Apply reset
        #10;
        $display("PC after reset: %h", dut.current_pc);
        
        // Test 6: ALU with immediate
        $display("Test 6: ALU with immediate");
        alu_ctrl = 1;  // Example ALU control
        alu_src = 1;   // Use immediate
        #10;
        $display("ALU result with immediate: %h", dut.alu_result);
        
        // End of test
        $finish;
    end

endmodule

