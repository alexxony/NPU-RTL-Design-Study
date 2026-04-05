module priority_encoder (
    input [3:0] req,      // 4개의 요청 신호
    output reg [1:0] code, // 선택된 요청의 번호
    output reg active      // 요청이 하나라도 있는지 여부
);
    // 조합 회로를 always @(*) 블록으로 작성 (Case 문 활용)
    always @(*) begin
        active = 1'b1;
        if (req[3])      code = 2'b11; // 3번이 가장 우선순위 높음
        else if (req[2]) code = 2'b10;
        else if (req[1]) code = 2'b01;
        else if (req[0]) code = 2'b00;
        else begin
            code = 2'b00;
            active = 1'b0;
        end
    end
endmodule