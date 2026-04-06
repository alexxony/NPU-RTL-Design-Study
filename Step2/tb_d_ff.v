`timescale 1ns/1ps

module tb_d_ff;
    reg clk;
    reg rst_n;
    reg d;
    wire q;

    // 1. 설계한 D-FF 모듈 불러오기 (Instantiate)
    d_ff uut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // 2. 클럭 생성: 10ns 주기로 0과 1을 반복 (100MHz)
    initial clk = 0;
    always #5 clk = ~clk; 

    initial begin
        // 파형 저장 설정
        $dumpfile("step2.vcd");
        $dumpvars(0, tb_d_ff);

        // 3. 초기화 (Reset)
        // 하드웨어는 시작할 때 반드시 리셋을 해서 초기 상태를 잡아줘야 합니다.
        rst_n = 0; d = 0;
        #12;             // 12ns 동안 리셋 유지
        rst_n = 1;       // 리셋 해제
        #10;

        // 4. 데이터 입력 및 타이밍 관찰
        d = 1; #10;      // d를 1로 바꿈
        d = 0; #10;      // d를 0으로 바꿈
        d = 1; #5;       // 클럭이 치기 직전에 d를 1로 바꿈 (아슬아슬한 타이밍)
        #15;
        d = 0; #20;

        $display("Simulation Finished!");
        $finish;
    end
endmodule