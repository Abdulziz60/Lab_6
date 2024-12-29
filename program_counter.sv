module program_counter #(
         parameter n = 32 
        )(
        input logic clk,
        input logic reset_n,
        input logic [n-1:0] data_in,
        output logic [n-1:0] data_o
        );
                        
        always@(posedge clk, negedge reset_n) begin
            if(!reset_n) begin
                data_o <= 0;
            end
            else begin
                data_o <= data_in;
            end
        end

endmodule                        