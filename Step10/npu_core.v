// Step10/npu_core.v
module npu_core (
    input clk,
    input rst_n,
    input start,          // 연산 시작 신호
    output reg done,      // 연산 완료 신호
    output [15:0] result0, result1 // 최종 결과값
);

    // FSM 상태 정의
    localparam IDLE    = 2'b00,
               LOAD    = 2'b01,
               COMPUTE = 2'b10,
               DONE    = 2'b11;

    reg [1:0] state, next_state;
    reg [3:0] counter;
    reg load, clear;

    // 1. 상태 전이
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= IDLE;
        else state <= next_state;
    end

    // 2. 다음 상태 결정
    always @(*) begin
        case (state)
            IDLE:    next_state = start ? LOAD : IDLE;
            LOAD:    next_state = (counter == 4'd2) ? COMPUTE : LOAD;
            COMPUTE: next_state = (counter == 4'd5) ? DONE : COMPUTE;
            DONE:    next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // 3. 제어 신호 및 카운터
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            load <= 0;
            clear <= 1;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    clear <= 1;
                    done <= 0;
                end
                LOAD: begin
                    load <= 1;
                    clear <= 0;
                    counter <= counter + 1;
                end
                COMPUTE: begin
                    load <= 0;
                    counter <= counter + 1;
                end
                DONE: begin
                    done <= 1;
                    counter <= 0;
                end
            endcase
        end
    end

    // 4. 하위 모듈(Array) 연결
    npu_array_1x2 array_inst (
        .clk(clk),
        .rst_n(rst_n),
        .clear(clear),
        .load(load),
        .w_in0(8'd2), .d_in0(8'd10),
        .w_in1(8'd3),
        .acc0(result0), .acc1(result1)
    );

endmodule