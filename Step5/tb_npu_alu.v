`timescale 1ns/1ps
module tb_npu_alu;
    reg clk, rst_n, start, ctrl_op;
    reg [7:0] a, b;
    wire [7:0] result;
    wire done;

    npu_alu uut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step5.vcd");
        $dumpvars(0, tb_npu_alu);

        rst_n = 0; start = 0; ctrl_op = 0; a = 0; b = 0;
        #12 rst_n = 1;

        // 시나리오 1: 10 + 5 (덧셈)
        #10 a = 8'd10; b = 8'd5; ctrl_op = 0; start = 1;
        #10 start = 0;
        #30;

        // 시나리오 2: 20 - 7 (뺄셈)
        #10 a = 8'd20; b = 8'd7; ctrl_op = 1; start = 1;
        #10 start = 0;
        #30;

        $finish;
    end
endmodule