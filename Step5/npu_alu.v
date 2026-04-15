// Step5/npu_alu.v
module npu_alu (
    input clk,
    input rst_n,
    input start,
    input ctrl_op,      // 0: Add, 1: Sub
    input [7:0] a,      // 입력 A
    input [7:0] b,      // 입력 B
    output reg [7:0] result,
    output reg done
);
    // 상태 정의
    parameter IDLE    = 2'b00;
    parameter COMPUTE = 2'b01;
    parameter DONE    = 2'b10;

    reg [1:0] curr_state, next_state;

    // 1. FSM 상태 전이
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) curr_state <= IDLE;
        else        curr_state <= next_state;
    end

    // 2. 다음 상태 결정
    always @(*) begin
        case (curr_state)
            IDLE:    next_state = start ? COMPUTE : IDLE;
            COMPUTE: next_state = DONE;
            DONE:    next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // 3. 연산 로직 (COMPUTE 상태에서만 수행)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result <= 8'h00;
            done   <= 1'b0;
        end else begin
            case (next_state)
                COMPUTE: begin
                    result <= ctrl_op ? (a - b) : (a + b);
                    done   <= 1'b0;
                end
                DONE: begin
                    done   <= 1'b1;
                end
                default: begin
                    done   <= 1'b0;
                end
            endcase
        end
    end
endmodule