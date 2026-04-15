// Step1/mux2to1.v
module mux2to1 (
    input [7:0] a,    // 데이터 입력 1
    input [7:0] b,    // 데이터 입력 2
    input       sel,  // 선택 신호 (0이면 a, 1이면 b)
    output [7:0] out
);
    // 조건 연산자를 사용하여 Mux 구현
    assign out = (sel) ? b : a;

endmodule