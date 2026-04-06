// Step2/d_ff.v
module d_ff (
    input clk,      // 하드웨어의 심장박동
    input rst_n,    // 리셋 (0일 때 초기화)
    input d,        // 입력
    output reg q    // 출력 (기억된 값)
);
    // posedge clk: 클럭이 0에서 1로 올라가는 순간에만 작동!
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule