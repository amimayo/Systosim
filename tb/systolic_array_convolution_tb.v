`timescale 1ns/1ps

module convolution_tb;

    reg clk, reset;
    reg [31:0] a, b;
    wire [511:0] result;

    systolic_array uut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("convolution_wave.vcd");
        $dumpvars(0, convolution_tb);
    end

    initial begin

        reset = 1;

        a = 32'h0;
        b = 32'h0;

        #10 reset = 0;

        @(posedge clk);

        a = 32'h00000001;
        b = 32'h00000001;

        @(posedge clk);

        a = 32'h00000302;
        b = 32'h00000000;

        @(posedge clk);

        a = 32'h00090405;
        b = 32'h00000000;

        @(posedge clk);

        a = 32'h0B0A0706;
        b = 32'h00000001;

        @(posedge clk);

        a = 32'h0C0D0800;
        b = 32'h00000000;

        @(posedge clk);

        a = 32'h0F0E0000;
        b = 32'h00000000;

        @(posedge clk);

        a = 32'h01000000;
        b = 32'h00000000;

        @(posedge clk);

        a = 32'h0;
        b = 32'h0;

        repeat(10) @(posedge clk);

        // A:             B:
        // 1 2 3 4        1 0 
        // 5 6 7 8        0 1
        // 9 10 11 12     
        // 13 14 15 1

        // Im2Col :
        //
        // Stride = 2
        //
        // Input1 :          Input2 :
        // 1 2 5 6           1 0 0 0
        // 3 4 7 8           0 0 0 0
        // 9 10 13 14        0 0 0 0
        // 11 12 15 0        1 0 0 0

        // Result :
        // 7 11
        // 23 12

        repeat(10) @(posedge clk);

        $display("========================");
        $display("Result : ");

        $display("%0d %0d", result[15*32 +: 32], result[11*32 +: 32]);
        $display("%0d %0d", result[7*32 +: 32], result[3*32 +: 32]);

        $display("========================");

        #10

        $finish;

    end

endmodule