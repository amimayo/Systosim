`include "pe.v"

module systolic_array #(parameter N = 8) (
    input clk,
    input reset,
    input [8*N - 1:0] a,
    input [8*N - 1:0] b,
    output [32*N*N - 1:0] result
);

    wire [7:0] horizontal[0:N-1][0:N];
    wire [7:0] vertical[0:N][0:N-1];

    //Generate for loops for Systolic Array :

    genvar i, j;

    generate
        for (i = 0; i < N; i= i + 1) begin
            
            assign horizontal[i][0] = a[i*8 +: 8];

            for (j = 0; j < N; j=j+1) begin
                
                if(i==0) begin
                    assign vertical[0][j] = b[j*8 +: 8];
                end

                PE pe_instance (
                    clk, 
                    reset, 
                    horizontal[i][j], 
                    vertical[i][j], 
                    horizontal[i][j+1], 
                    vertical[i+1][j], 
                    result[32*(N*N - 1 - (i*N + j)) +: 32]
                );

            end
        end
    endgenerate

endmodule