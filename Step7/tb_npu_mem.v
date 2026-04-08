`timescale 1ns/1ps
module tb_npu_mem;
    reg clk, wr_en;
    reg [3:0] addr;
    reg [7:0] data_in;
    wire [7:0] data_out;

    npu_mem uut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step7.vcd");
        $dumpvars(0, tb_npu_mem);

        wr_en = 0; addr = 0; data_in = 0;
        #10;

        // 1. 주소 5번에 데이터 8'hA5 쓰기
        addr = 4'd5; data_in = 8'hA5; wr_en = 1;
        #10;

        // 2. 주소 10번에 데이터 8'h3C 쓰기
        addr = 4'd10; data_in = 8'h3C; wr_en = 1;
        #10;

        // 3. 쓰기 종료 및 읽기 모드로 전환
        wr_en = 0;
        
        // 4. 주소 5번 데이터 읽기 (A5가 나와야 함)
        addr = 4'd5;
        #10;

        // 5. 주소 10번 데이터 읽기 (3C가 나와야 함)
        addr = 4'd10;
        #10;

        $finish;
    end
endmodule