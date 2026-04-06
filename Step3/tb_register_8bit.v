`timescale 1ns/1ps

module tb_register_8bit;
    reg clk;
    reg rst_n;
    reg [7:0] d_in;
    reg load;
    wire [7:0] q_out;

    // 1. 설계한 8-bit Register 모듈 호출
    register_8bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .d_in(d_in),
        .load(load),
        .q_out(q_out)
    );

    // 2. 클럭 생성 (10ns 주기, 100MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // 파형 저장 설정
        $dumpfile("step3.vcd");
        $dumpvars(0, tb_register_8bit);

        // 3. 초기화 (Reset)
        rst_n = 0; load = 0; d_in = 8'h00;
        #12 rst_n = 1; // 12ns 후에 리셋 해제

        // 4. 테스트 시나리오
        // 시나리오 A: load가 0일 때 데이터 입력 (변하지 않아야 함)
        #10 d_in = 8'hAA; load = 0; 
        #10; // 다음 클럭이 지나도 q_out은 00이어야 함

        // 시나리오 B: load를 1로 설정 (데이터 저장)
        #5  load = 1;
        #15; // 클럭 상승 에지 이후 q_out이 AA로 변함

        // 시나리오 C: 데이터 변경 후 load 유지
        #10 d_in = 8'h55;
        #10; // 다음 클럭 상승 에지 이후 q_out이 55로 변함

        // 시나리오 D: load를 0으로 설정 (데이터 유지/기억)
        #5  load = 0;
        #10 d_in = 8'hFF; // 입력은 FF로 바뀌지만
        #20;             // load가 0이므로 q_out은 55를 유지해야 함

        $display("Step 3 Simulation Finished!");
        $finish;
    end
endmodule