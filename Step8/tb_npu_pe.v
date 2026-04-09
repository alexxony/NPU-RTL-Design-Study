`timescale 1ns/1ps
module tb_npu_pe;
    reg clk, rst_n, clear, load;
    reg [7:0] w_in, d_in;
    wire [15:0] acc_out;
    wire [7:0] w_reg, d_reg;

    npu_pe uut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step8.vcd");
        $dumpvars(0, tb_npu_pe);

        rst_n = 0; clear = 0; load = 0; w_in = 0; d_in = 0;
        #12 rst_n = 1;

        // 데이터 로드 및 계산 시작
        #10 w_in = 8'd3; d_in = 8'd4; load = 1;
        #10 load = 0; // 이제 외부 입력이 바뀌어도 PE는 3과 4를 기억함
        
        #10 w_in = 8'd99; d_in = 8'd99; // 외부 입력을 바꿔봄
        #20; // 하지만 acc_out은 여전히 3*4=12를 유지하거나 누적해야 함

        $finish;
    end
endmodule