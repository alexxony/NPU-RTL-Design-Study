// Step8/npu_pe.v
module npu_pe (
    input clk,
    input rst_n,
    input clear,        // 누산기 초기화
    input load,         // 레지스터에 새로운 데이터를 받을지 결정
    input [7:0] w_in,   // 외부에서 들어오는 가중치
    input [7:0] d_in,   // 외부에서 들어오는 데이터
    output [15:0] acc_out, // 계산 결과
    output reg [7:0] w_reg, // 다음 PE로 넘겨줄 가중치
    output reg [7:0] d_reg  // 다음 PE로 넘겨줄 데이터
);

    // 1. 데이터를 잡아두는 레지스터 (Desk)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            w_reg <= 8'h0;
            d_reg <= 8'h0;
        end else if (load) begin
            w_reg <= w_in;
            d_reg <= d_in;
        end
    end

    // 2. Step 6에서 만든 MAC 유닛을 일꾼으로 고용 (부품 호출)
    // 주의: Step6/npu_mac.v 파일이 같은 경로에 있거나 컴파일 시 포함되어야 합니다.
    npu_mac mac_inst (
        .clk(clk),
        .rst_n(rst_n),
        .clear(clear),
        .w(w_reg),    // 내가 보관 중인 가중치 사용
        .in(d_reg),   // 내가 보관 중인 데이터 사용
        .acc_out(acc_out)
    );

endmodule