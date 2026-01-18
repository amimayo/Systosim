`timescale 1ns/1ps

module matmulNxN_tb;

    parameter N = 8;
    reg clk, reset;
    reg [8*N - 1:0] a, b;
    wire [32*N*N - 1:0] result;
    integer i, j, t;

    reg [7:0] mem_a[0:N*N - 1];
    reg [7:0] mem_b[0:N*N - 1];


    systolic_array #(.N(N)) uut (
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
        $dumpfile("matmulNxN_wave.vcd");
        $dumpvars(0, matmulNxN_tb);
        
    end

    initial begin

        $readmemh("./sim/matmul_NxN_sim/matrix_a.txt", mem_a);
        $readmemh("./sim/matmul_NxN_sim/matrix_b.txt", mem_b);
        
        reset = 1;

        a = 0;
        b = 0;

        #10 reset = 0;

        for (t = 0; t < 3*N ; t = t + 1) begin

            @(posedge clk);

            for (i = 0; i < N; i = i + 1) begin
                
                if(t >= i && (t-i) < N) begin
                    a[i*8 +: 8] = mem_a[i*N + (t-i)];
                    b[i*8 +: 8] = mem_b[(t-i)*N + i];
                end

                else begin
                    a[i*8 +: 8] = 0;
                    b[i*8 +: 8] = 0;
                end

            end
        end

        repeat(N*2) @(posedge clk);

        //A :
        // 1 2 3 4 5 6 7 8   
        // 2 3 4 5 6 7 8 9
        // 3 4 5 6 7 8 9 10
        // 4 5 6 7 8 9 10 11
        // 5 6 7 8 9 10 11 12
        // 6 7 8 9 10 11 12 13
        // 7 8 9 10 11 12 13 14
        // 8 9 10 11 12 13 14 15

        //B :
        // 15 14 13 12 11 10 9 8
        // 14 13 12 11 10 9 8 7
        // 13 12 11 10 9 8 7 6
        // 12 11 10 9 8 7 6 5
        // 11 10 9 8 7 6 5 4
        // 10 9 8 7 6 5 4 3
        // 9 8 7 6 5 4 3 2
        // 8 7 6 5 4 3 2 1
        
        // Result :
        // 372 336 300 264 228 192 156 120
        // 464 420 376 332 288 244 200 156
        // 556 504 452 400 348 296 244 192
        // 648 588 528 468 408 348 288 228
        // 740 672 604 536 468 400 332 264
        // 832 756 680 604 528 452 376 300
        // 924 840 756 672 588 504 420 336
        // 1016 924 832 740 648 556 464 372

        $display("========================");
        $display("Result : ");
        for (i = 0; i < N; i = i + 1) begin
            for (j = 0; j < N; j = j + 1) begin
                $write("%0d ", result[32*(N*N - 1 - (i*N + j)) +: 32]);
            end
            $display("");
        end
        $display("========================");

        #10

        $finish;

    end


endmodule