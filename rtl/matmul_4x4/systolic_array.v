`include "pe.v"

module systolic_array (
    input clk,
    input reset,
    input [31:0] a,
    input [31:0] b,
    output [511:0] result
);

wire [7:0] a_in01, a_in02, a_in03, a_out1; 
wire [7:0] a_in11, a_in12, a_in13, a_out2; 
wire [7:0] a_in21, a_in22, a_in23, a_out3; 
wire [7:0] a_in31, a_in32, a_in33, a_out4;

wire [7:0] b_in10, b_in20, b_in30, b_out1;
wire [7:0] b_in11, b_in21, b_in31, b_out2;
wire [7:0] b_in12, b_in22, b_in32, b_out3;
wire [7:0] b_in13, b_in23, b_in33, b_out4;

wire [31:0] result_00, result_01, result_02, result_03;
wire [31:0] result_10, result_11, result_12, result_13;
wire [31:0] result_20, result_21, result_22, result_23;
wire [31:0] result_30, result_31, result_32, result_33;

PE pe_00 (clk, reset, a[7:0], b[7:0], a_in01, b_in10, result_00);
PE pe_01 (clk, reset, a_in01, b[15:8], a_in02, b_in11, result_01);
PE pe_02 (clk, reset, a_in02, b[23:16], a_in03, b_in12, result_02);
PE pe_03 (clk, reset, a_in03, b[31:24], a_out1, b_in13, result_03);

PE pe_10 (clk, reset, a[15:8], b_in10, a_in11, b_in20, result_10);
PE pe_11 (clk, reset, a_in11, b_in11, a_in12, b_in21, result_11);
PE pe_12 (clk, reset, a_in12, b_in12, a_in13, b_in22, result_12);
PE pe_13 (clk, reset, a_in13, b_in13, a_out2, b_in23, result_13);

PE pe_20 (clk, reset, a[23:16], b_in20, a_in21, b_in30, result_20);
PE pe_21 (clk, reset, a_in21, b_in21, a_in22, b_in31, result_21);
PE pe_22 (clk, reset, a_in22, b_in22, a_in23, b_in32, result_22);
PE pe_23 (clk, reset, a_in23, b_in23, a_out3, b_in33, result_23);

PE pe_30 (clk, reset, a[31:24], b_in30, a_in31, b_out1, result_30);
PE pe_31 (clk, reset, a_in31, b_in31, a_in32, b_out2, result_31);
PE pe_32 (clk, reset, a_in32, b_in32, a_in33, b_out3, result_32);
PE pe_33 (clk, reset, a_in33, b_in33, a_out4, b_out4, result_33);

assign result = { result_00, result_01, result_02, result_03,
                  result_10, result_11, result_12, result_13,
                  result_20, result_21, result_22, result_23,
                  result_30, result_31, result_32, result_33 };

endmodule