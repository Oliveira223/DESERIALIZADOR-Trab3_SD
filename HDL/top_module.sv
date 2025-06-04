module top_module(
    input logic clock_1M,
    input logic reset,

    input  logic data_in,           //entrada de bit em bit
    input  logic write_in,     

    output logic [7:0] data_out,
    output logic status_out     
);

   //sinais internos do top
    logic clock_100k, clock_10k;
    logic [7:0] data_out_des;
    logic data_ready_des;
    logic ack_in;
    logic enq_in, deq_in;
    logic [7:0] data_out_queue;
    logic [3:0] len_out_queue;
    logic status_queue;

    deserializer des (
        .clock_100k  (clock_100k),
        .reset      (reset),
        .data_in    (data_in),
        .write_in   (write_in),
        .ack_in     (ack_in),
        .data_out   (data_out_des),
        .data_ready (data_ready_des)
    );

   queue que (
        .reset      (reset),
        .clock_10k   (clock_10k),
        .data_in    (data_out_des),
        .enq_in     (enq_in),
        .deq_in     (deq_in),
        .data_out   (data_out_queue),
        .len_out    (len_out_queue),
        .status_out (status_queue)
    );

    clock_divider clk_div(
        .reset          (reset),
        .clock_1M       (clock_1M),
        .clock_100k     (clock_100k),
        .clock_10k      (clock_10k)
    );

    //output (saidas da fila)
    assign data_out   = data_out_queue;
    assign status_out = status_queue;


endmodule