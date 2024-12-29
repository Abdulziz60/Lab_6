`timescale 1ns / 1ps

module alu_control_tb;

    // Inputs
    reg alu_op;
    reg [31:0] inst;

    // Output
    wire alu_ctrl;

    // Instantiate the ALU control unit
    alu_control dut (
        .alu_op(alu_op),
        .inst(inst),
        .alu_ctrl(alu_ctrl)
    );

    // Test process
    initial begin
        // Test 1: Load/Store operation (alu_op = 2'b00)
        $display("Test 1: Load/Store operation (alu_op = 2'b00)");
        alu_op = 2'b00;
        inst = 32'h00000000;  // Just a dummy instruction
        #10;  // Wait for 10 time units
        $display("alu_ctrl = %b", alu_ctrl);
        
        // Test 2: BEQ operation (alu_op = 2'b01)
        $display("Test 2: BEQ operation (alu_op = 2'b01)");
        alu_op = 2'b01;
        inst = 32'h00000000;  // Dummy instruction for BEQ
        #10;
        $display("alu_ctrl = %b", alu_ctrl);

        // Test 3: R-type operation (alu_op = 2'b10) with func7 and func3
        $display("Test 3: R-type operation (alu_op = 2'b10)");
        alu_op = 2'b10;
        inst = 32'h00000033;  // Example R-type instruction (func3 = 3'b000, func7 = 7'b0000000)
        #10;
        $display("alu_ctrl = %b", alu_ctrl);

        // Test 4: I-type operation (alu_op = 2'b11) with func3
        $display("Test 4: I-type operation (alu_op = 2'b11)");
        alu_op = 2'b11;
        inst = 32'h00000013;  // Example I-type instruction (func3 = 3'b000)
        #10;
        $display("alu_ctrl = %b", alu_ctrl);

        // Test 5: Default case (invalid alu_op)
        $display("Test 5: Default case (invalid alu_op)");
        alu_op = 2'bxx;  // Invalid alu_op
        inst = 32'h00000000;  // Dummy instruction
        #10;
        $display("alu_ctrl = %b", alu_ctrl);

        // End the simulation
        $finish;
    end

endmodule
