`timescale 1ns/1ps
module tb_npu_array;
    reg clk, rst_n, clear, load;
    reg [7:0] w_in0, w_in1, d_in0;
    wire [15:0] acc0, acc1;

    npu_array_1x2 uut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step9.vcd");
        $dumpvars(0, tb_npu_array);

        rst_n = 0; clear = 0; load = 0;
        w_in0 = 8'd2; w_in1 = 8'd3; d_in0 = 8'd10;
        #12 rst_n = 1;

        // 기존의 짧은 load 구간은 주석 처리해서 막아버립니다.
        // #10 load = 1;
        // #10 load = 0;

        // 수정 코드 (데이터가 PE1까지 도달하도록 한 박자 더 기다림)
        #10 load = 1;
        #20 load = 0; // 10ns가 아니라 20ns 동안 유지!

        #50;
        $finish;
    end
endmodule