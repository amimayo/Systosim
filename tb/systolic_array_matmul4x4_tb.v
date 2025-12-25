`timescale 1ns/1ps

module matmul_tb;

    reg clk, reset;
    reg [31:0] a, b;
    wire [511:0] result;

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
        $display("%0d %0d %0d %0d", result[511:480], result[479:448], result[447:416], result[415:384]);
        $display("%0d %0d %0d %0d", result[383:352], result[351:320], result[319:288], result[287:256]);
        $display("%0d %0d %0d %0d", result[255:224], result[223:192], result[191:160], result[159:128]);
        $display("%0d %0d %0d %0d", result[127:96], result[95:64], result[63:32], result[31:0]);
         $display("========================");

        #10

        $finish;

    end


endmodule