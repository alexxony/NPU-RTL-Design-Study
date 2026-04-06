`timescale 1ns/1ps
module tb_fsm_controller;
    reg clk, rst_n, start;
    wire [1:0] current_state;
    wire busy;

    fsm_controller uut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("step4.vcd");
        $dumpvars(0, tb_fsm_controller);
        
        rst_n = 0; start = 0; #12;
        rst_n = 1; #10;
        
        start = 1; #10; // Start!
        start = 0; #40;
        
        $finish;
    end
endmodule