// Step3/register_8bit.v
module register_8bit (
    input clk,
    input rst_n,
    input [7:0] d_in,   // 8비트 입력 (가중치 데이터 등)
    input load,         // 데이터 저장 신호 (1일 때만 저장)
    output reg [7:0] q_out // 8비트 출력
);
    // 클럭의 상승 에지에서 동작
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q_out <= 8'b0;      // 리셋 시 0으로 초기화
        end else if (load) begin
            q_out <= d_in;      // load가 1일 때만 새로운 데이터를 받아들임
        end
        // else: load가 0이면 이전 값을 그대로 유지 (기억 기능)
    end
endmodule