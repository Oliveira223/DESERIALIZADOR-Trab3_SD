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

// enviar vetores de 8 bits

//send_vec(0000001);
//send_vec(0000010);


//é que manualmente a gente consegue ter um melhor controle das flags, usando a task n dá


 data_in = 8'h11; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h22; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h33; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h44; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h55; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h66; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h77; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h88; enqueue_in = 1; #50; enqueue_in = 0;
        data_in = 8'h99; enqueue_in = 1; #50; enqueue_in = 0;

        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;
        dequeue_in = 1; #50; dequeue_in = 0;



task send_vec(input logic vec_val);
    begin
      @(posedge clock_10);
      data_in = vec_val;
      enq_in= 1;
      @(posedge clock_10);
      enq_in = 0;
    end
  endtask

endmodule

