`timescale 1ns/1ps

module matmul_tb;

    reg clk, reset;
    reg [31:0] a, b;
    wire [511:0] result;
    integer i;

    systolic_array uut(
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
        $dumpfile("matmul4x4_wave.vcd");
        $dumpvars(0, matmul_tb);
        
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

        a = 32'h00000502;
        b = 32'h00000502;

        @(posedge clk);

        a = 32'h00090603;
        b = 32'h00090603;

        @(posedge clk);

        a = 32'h0D0A0704;
        b = 32'h0D0A0704;

        @(posedge clk);

        a = 32'h0E0B0800;
        b = 32'h0E0B0800;

        @(posedge clk);

        a = 32'h0F0C0000;
        b = 32'h0F0C0000;

        @(posedge clk);

        a = 32'h01000000;
        b = 32'h01000000;

        @(posedge clk);

        a = 32'h0;
        b = 32'h0;

        repeat(10) @(posedge clk);

        // A:             B:
        // 1 2 3 4        1 5 9 13
        // 5 6 7 8        2 6 10 14
        // 9 10 11 12     3 7 11 15
        // 13 14 15 1     4 8 12 1

        // Result :
        // 30 70 110 90
        // 70 174 278 262
        // 110 278 446 434
        // 90 262 434 591

        $display("========================");
        $display("Result : ");

        for(i=0; i < 4; i = i + 1) begin
            $display("%0d %0d %0d %0d", result[(15 - i*4)*32 +: 32], result[(14 - i*4)*32 +: 32], result[(13 - i*4)*32 +: 32], result[(12 - i*4)*32 +: 32]);
        end
        $display("========================");

        #10

        $finish;

    end


endmodule