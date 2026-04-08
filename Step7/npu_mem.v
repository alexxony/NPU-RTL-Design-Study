// Step7/npu_mem.v
module npu_mem (
    input clk,
    input wr_en,          // 1: Write(쓰기), 0: Read(읽기)
    input [3:0] addr,     // 4비트 주소 (2^4 = 16개의 공간)
    input [7:0] data_in,  // 저장할 데이터
    output reg [7:0] data_out // 읽어온 데이터
);

    // 8비트 크기의 방을 16개 만듭니다 (메모리 배열)
    reg [7:0] mem_array [0:15];

    // 클럭의 상승 에지에서 동작
    always @(posedge clk) begin
        if (wr_en) begin
            // 쓰기 모드: 선택한 주소(addr)에 데이터 저장
            mem_array[addr] <= data_in;
        end else begin
            // 읽기 모드: 선택한 주소(addr)에서 데이터 출력
            data_out <= mem_array[addr];
        end
    end
endmodule