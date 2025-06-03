`timescale 1ns/1ps

module tb_divisor;

    logic reset;
    logic clock_1M;
    wire clock_100k;
    wire clock_10k;

    clock_divisor dut (
        .clock_1M(clock_1M),
        .reset(reset),
        .clock_10k(clock_10k),
        .clock_100k(clock_100k)
    );

    initial clock_1M = 0;
    always #0.5 clock_1M = ~clock_1M;
    initial begin
        reset = 1;
        #2;
        reset = 0;
        #1000;
        $finish;
    end

endmodule