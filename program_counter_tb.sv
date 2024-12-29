`timescale 1ns / 1ps


module program_counter_tb #(parameter WIDTH = 32);
    
    logic [WIDTH-1:0]data_in;
    logic clk;
    logic reset_n;
    logic [WIDTH-1:0]data_out;
    
program_counter #(.WIDTH(WIDTH)) PC (
    .data_in(data_in),
    .clk(clk),              
    .reset_n(reset_n),          
    .data_out(data_out) 
    );    

always #5 clk = ~clk;
initial begin

    clk = 1'b0;
    reset_n = 1'b0;
    reset_n = 1'b1;
    
    data_in = 32'b111001;
#10
    reset_n = 1'b0;
#10
    reset_n = 1'b1;
#50
    data_in = 32'b101001;
#50
    data_in = 32'b100010111001;
    
       
#300
$finish;
end
endmodule