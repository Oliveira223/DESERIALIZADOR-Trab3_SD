`timescale 1us/1ns
module queue_tb;

logic clock_10k = 0;
logic reset;
logic [7:0] data_in;
logic enq_in;
logic deq_in;
logic [7:0] data_out;
logic [3:0] len_out;
logic status_out;

queue dut (
    .clock_10k (clock_10k),
    .reset    (reset),
    .data_in  (data_in),
    .enq_in   (enq_in),
    .deq_in   (deq_in),
    .data_out (data_out),
    .len_out  (len_out),
    .status_out (status_out)
);

always #50 clock_10k = ~clock_10k;

initial begin
    reset = 1;
    enq_in = 0;
    deq_in = 0;
    data_in = 0;

    #100 reset = 0;

    // Enqueue
    repeat(9) begin
        @(negedge clock_10k);
        data_in = data_in + 8'h11;
        enq_in = 1;
        @(negedge clock_10k);
        enq_in = 0;
    end

    // Dequeue
    repeat(5) begin
        @(negedge clock_10k);
        deq_in = 1;
        @(negedge clock_10k);
        deq_in = 0;
    end

    

     // Enqueue
    repeat(7) begin //teste para ver se sobreescreve
        @(negedge clock_10k);
        data_in = data_in + 8'h11;
        enq_in = 1;
        @(negedge clock_10k);
        enq_in = 0;
    end

    $stop;
end

// Monitor
always @(posedge clock_10k) begin
    $display("[Time %0t] len=%0d | data_out=%h | status=%b \n\n\n", $time, len_out, data_out, status_out);
end

endmodule
