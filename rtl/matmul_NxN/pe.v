module PE (
    input clk,
    input reset,
    input [7:0] in1,
    input [7:0] in2,
    output reg [7:0] out1,
    output reg [7:0] out2,
    output reg [31:0] mac_out
);

    always @(posedge clk or posedge reset) begin

        if(reset) begin
            mac_out <= 0;
            out1 <=  0;
            out2 <= 0;
        end
        else begin
            mac_out <= mac_out + (in1*in2);
            out1 <= in1;
            out2 <= in2;
        end

   end

endmodule