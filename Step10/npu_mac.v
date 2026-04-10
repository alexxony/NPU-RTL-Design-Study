// Step6/npu_mac.v
module npu_mac (
    input clk,
    input rst_n,
    input clear,          // 저금통 비우기 (누산기 초기화)
    input [7:0] w,        // 가중치
    input [7:0] in,       // 입력 데이터
    output reg [15:0] acc_out // 누적된 결과 (8bit*8bit = 16bit 필요)
);

    wire [15:0] mul_res;
    
    // 1. 곱셈 단계 (Combinational)
    assign mul_res = w * in;

    // 2. 누적 단계 (Sequential)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_out <= 16'h0000;
        end else if (clear) begin
            acc_out <= 16'h0000; // clear 신호가 오면 0으로 리셋
        end else begin
            // 핵심: 기존 값(acc_out)에 새로운 곱셈 결과(mul_res)를 더해서 다시 저장!
            acc_out <= acc_out + mul_res;
        end
    end
endmodule