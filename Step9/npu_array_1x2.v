// Step9/npu_array_1x2.v
module npu_array_1x2 (
    input clk,
    input rst_n,
    input clear,
    input load,
    input [7:0] w_in0, d_in0, // 첫 번째 일꾼용 재료
    input [7:0] w_in1,        // 두 번째 일꾼용 가중치
    output [15:0] acc0, acc1  // 두 일꾼의 결과물
);

    wire [7:0] d_pass; // 첫 번째 일꾼이 쓰고 옆으로 넘겨줄 데이터 통로

    // [PE 0] 첫 번째 일꾼
    npu_pe pe0 (
        .clk(clk), .rst_n(rst_n), .clear(clear), .load(load),
        .w_in(w_in0), .d_in(d_in0),
        .acc_out(acc0),
        .w_reg(),     // 가중치는 일단 안 넘김
        .d_reg(d_pass) // ★중요: 내가 쓴 데이터를 d_pass에 실어서 옆으로 보냄!
    );

    // [PE 1] 두 번째 일꾼
    npu_pe pe1 (
        .clk(clk), .rst_n(rst_n), .clear(clear), .load(load),
        .w_in(w_in1), 
        .d_in(d_pass), // ★중요: 옆 일꾼(pe0)이 넘겨준 데이터를 받아서 씀!
        .acc_out(acc1),
        .w_reg(), .d_reg()
    );

endmodule