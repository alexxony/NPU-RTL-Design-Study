module fsm_controller (
    input clk,
    input rst_n,
    input start,
    output reg [1:0] current_state,
    output reg busy
);
    // 상태 정의 (Parameter)
    parameter IDLE    = 2'b00;
    parameter COMPUTE = 2'b01;
    parameter DONE    = 2'b10;

    reg [1:0] next_state;

    // 1. 상태 전이 로직 (Sequential)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) current_state <= IDLE;
        else        current_state <= next_state;
    end

    // 2. 다음 상태 결정 로직 (Combinational)
    always @(*) begin
        case (current_state)
            IDLE:    next_state = start ? COMPUTE : IDLE;
            COMPUTE: next_state = DONE; // 실제론 연산 완료 신호를 기다리지만 여기선 즉시 이동
            DONE:    next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // 3. 출력 로직
    always @(*) begin
        busy = (current_state == COMPUTE);
    end
endmodule