`timescale 1us/1ns
module queue_tb; 
logic clock_10 = 0; // clock 10KHZ
logic reset;

logic data_in;
logic enq_in;
logic deq_in;

logic data_out;
logic [7:0] len_out; // sinal de 8 bits

queue dut (
    
.clock_10 (clock_10),
.reset (reset),
.data_in (data_in),
.enq_in (enq_in),
.deq_in (deq_in),
.data_out (data_out),
.len_out(len_out)
);

// Periodo = 1 / frequencia
// Periodo = 1 / 10Khz
// Periodo = 100us 
// Clock   = 100us/2 
always #50 clock_10 = ~clock_10;  // clock 10kHz


initial begin

reset = 1;
enq_in = 1;
deq_in = 0;
data_in = 0;
len_out = 0;

#10

reset = 0;

data_in = 8'h11; enq_in = 1; #50; enq_in = 0;
data_in = 8'h22; enq_in = 1; #50; enq_in = 0;
data_in = 8'h33; enq_in = 1; #50; enq_in = 0;
data_in = 8'h44; enq_in = 1; #50; enq_in = 0;
data_in = 8'h55; enq_in = 1; #50; enq_in = 0;
data_in = 8'h66; enq_in = 1; #50; enq_in = 0;
data_in = 8'h77; enq_in = 1; #50; enq_in = 0;
data_in = 8'h88; enq_in = 1; #50; enq_in = 0;
data_in = 8'h99; enq_in = 1; #50; enq_in = 0;

deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;
deq_in = 1; #50; deq_in = 0;

$stop;
end

endmodule

