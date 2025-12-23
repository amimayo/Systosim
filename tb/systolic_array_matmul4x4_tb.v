`timescale 1ns/1ps

module matmul_tb;

    reg clk, reset;
    reg [31:0] a, b;
    wire [511:0] result;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("matmul4.vcd");
        $dumpvars(0, sys_array_matmul_tb);
        
    end

    //TODO : Testbench


endmodule