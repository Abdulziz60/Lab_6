`timescale 1ns / 1ps


module inst_mem_tb ;

    // Parameters
    parameter WIDTH = 32;
    parameter DEPTH = 256;

    // Signals
    logic [WIDTH-1:0] address;
    logic [WIDTH-1:0] instruction;

    // Instantiate the design under test (DUT)
    inst_mem #(WIDTH, DEPTH) dut (
        .address(address),
        .instruction(instruction)
    );

    // Test process
    initial begin
        // Initialize signals
        address = 32'b0;

        // Test 1: Read instruction from address 0
        #10;
        address = 32'h0000; // Address 0
        #10;
        $display("Address: %h, Instruction: %h", address, instruction);
        
        // Test 2: Read instruction from address 4
        #10;
        address = 32'h0004; // Address 4
        #10;
        $display("Address: %h, Instruction: %h", address, instruction);

        // Test 3: Read instruction from address 8
        #10;
        address = 32'h0008; // Address 8
        #10;
        $display("Address: %h, Instruction: %h", address, instruction);

        // Test 4: Read instruction from address 12
        #10;
        address = 32'h000C; // Address 12
        #10;
        $display("Address: %h, Instruction: %h", address, instruction);

        // Test 5: Read instruction from address at max (DEPTH-1) i.e., 0xFFFC
        #10;
        address = 32'hFFFC; // Max address, corresponding to last memory entry
        #10;
        $display("Address: %h, Instruction: %h", address, instruction);

        // Test 6: Test address greater than depth (invalid address, should ideally not happen)
        #10;
        address = 32'h1000; // Invalid address
        #10;
        $display("Address: %h, Instruction: %h", address, instruction);

        // End of test
        $finish;
    end

endmodule
