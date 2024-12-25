`timescale 1ns / 1ps

module data_path_tb;

    // Testbench Signals
    reg clk;
    reg reset_n;
    reg [3:0] alu_ctrl;       // ALU control signal
    reg memtoreg;             // Memory-to-register selector
    reg branch;               // Branch selector
    reg alu_src;              // ALU source selector
    reg mem_write;            // Memory write control
    reg reg_write;            // Register write control

    // Outputs to monitor
    wire Zero;                // Zero flag from ALU
    wire [31:0] current_pc;   // Current program counter
    wire [31:0] next_pc;      // Next program counter
    wire [31:0] alu_result;   // ALU result

    // Instantiate the DUT (Device Under Test)
    data_path dut (
        .clk(clk),
        .reset_n(reset_n)
    );

    // Clock Generation
    always #5 clk = ~clk; // 10 ns clock period

    // Initialization and Reset
    initial begin
        clk = 0;
        reset_n = 0;

        // Reset the DUT
        #10;
        reset_n = 1;

        // Test different selector configurations
        test_selectors();

        // Finish the simulation
        #1000;
        $finish;
    end

    // Task to test all selector values
    task test_selectors();
        begin
            // Test 1: ALU Control for ADD
            alu_ctrl = 4'b0000; // ADD operation
            alu_src = 0;        // Use register data as source
            branch = 0;         // No branching
            memtoreg = 0;       // Use ALU result as data
            mem_write = 0;      // No memory write
            reg_write = 1;      // Write to register
            #20;

            // Test 2: ALU Control for SUB
            alu_ctrl = 4'b0001; // SUB operation
            alu_src = 1;        // Use immediate as source
            branch = 1;         // Enable branching
            memtoreg = 1;       // Use memory data as result
            mem_write = 0;      // No memory write
            reg_write = 1;      // Write to register
            #20;

            // Test 3: Memory Write
            alu_ctrl = 4'b0010; // AND operation
            alu_src = 0;        // Use register data as source
            branch = 0;         // No branching
            memtoreg = 0;       // Use ALU result as data
            mem_write = 1;      // Enable memory write
            reg_write = 0;      // No register write
            #20;

            // Test 4: Branching
            alu_ctrl = 4'b0100; // OR operation
            alu_src = 1;        // Use immediate as source
            branch = 1;         // Enable branching
            memtoreg = 0;       // Use ALU result as data
            mem_write = 0;      // No memory write
            reg_write = 0;      // No register write
            #20;

            // Test 5: Memory-to-Register
            alu_ctrl = 4'b1000; // XOR operation
            alu_src = 1;        // Use immediate as source
            branch = 0;         // No branching
            memtoreg = 1;       // Use memory data as result
            mem_write = 0;      // No memory write
            reg_write = 1;      // Write to register
            #20;
        end
    endtask

    // Monitor Outputs
    initial begin
        $monitor(
            "Time: %0t | PC: %h | Next PC: %h | ALU Result: %h | Zero: %b | alu_ctrl: %b | memtoreg: %b | branch: %b | alu_src: %b | mem_write: %b | reg_write: %b",
            $time, current_pc, next_pc, alu_result, Zero, alu_ctrl, memtoreg, branch, alu_src, mem_write, reg_write
        );
    end
endmodule
