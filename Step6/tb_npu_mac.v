`timescale 1ns/1ps
module tb_npu_mac;
    reg clk, rst_n, clear;
    reg [7:0] w, in;
    wire [15:0] acc_out;

    npu_mac uut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step6.vcd");
        $dumpvars(0, tb_npu_mac);

        rst_n = 0; clear = 0; w = 0; in = 0;
        #12 rst_n = 1;

        // 1. 첫 번째 연산: 2 * 3 = 6
        #10 w = 8'd2; in = 8'd3; 
        // 2. 두 번째 연산: 4 * 5 = 20 (누적 결과: 6 + 20 = 26)
        #10 w = 8'd4; in = 8'd5;
        // 3. 세 번째 연산: 10 * 10 = 100 (누적 결과: 26 + 100 = 126)
        #10 w = 8'd10; in = 8'd10;
        
        #20;
        $finish;
    end
endmodule