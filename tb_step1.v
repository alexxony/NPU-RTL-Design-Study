`timescale 1ns/1ps

module tb_step1;
    // Mux용 변수
    reg [7:0] a, b;
    reg sel;
    wire [7:0] mux_out;

    // Encoder용 변수
    reg [3:0] req;
    wire [1:0] code;
    wire active;

    // 모듈 인스턴스화
    mux2to1 u_mux (.a(a), .b(b), .sel(sel), .out(mux_out));
    priority_encoder u_enc (.req(req), .code(code), .active(active));

    initial begin
        $dumpfile("step1.vcd");
        $dumpvars(0, tb_step1);

        // 1. Mux 테스트
        a = 8'hAA; b = 8'hBB; sel = 0; #10;
        $display("[MUX] sel:%b, out:%h (Expected: AA)", sel, mux_out);
        sel = 1; #10;
        $display("[MUX] sel:%b, out:%h (Expected: BB)", sel, mux_out);

        // 2. Encoder 테스트
        req = 4'b0001; #10;
        $display("[ENC] req:%b, code:%d", req, code);
        req = 4'b1010; #10; // 3번과 1번이 동시에 켜짐
        $display("[ENC] req:%b, code:%d (Expected: 3)", req, code);

        $finish;
    end
endmodule