// Step10/tb_npu_core.v
`timescale 1ns/1ps

module tb_npu_core; // 괄호 없음! 세미콜론으로 끝!

    reg clk, rst_n, start;
    wire done;
    wire [15:0] result0, result1;

    // 테스트할 기계(npu_core)를 불러옴
    npu_core uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .result0(result0),
        .result1(result1)
    );

    // 클럭 생성 (10ns 주기)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step10.vcd");
        $dumpvars(0, tb_npu_core);

        // 초기화
        rst_n = 0; start = 0;
        #12 rst_n = 1;
        
        // 연산 시작 신호
        #10 start = 1;
        #10 start = 0;

        // 완료될 때까지 대기
        wait(done);
        #20;
        
        $display("Simulation Finished!");
        $display("Result0: %d, Result1: %d", result0, result1);
        $finish;
    end

endmodule