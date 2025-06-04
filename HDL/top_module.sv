module top_module(
    input  logic        clock_1M,
    input  logic        reset,
    input  logic        data_in,    // entrada serial (1 bit)
    input  logic        write_in,   // indica que “data_in” é válido neste ciclo
    input  logic        deq_in,     // sinal de “dequeue” para a fila

    output logic [7:0]  data_out,   // vetor retirado da fila
    output logic [3:0]  len_out,    // quantidade de elementos atualmente na fila
    output logic        status_out  // flag de erro de fila cheia/vazia
);

    //sinais pra o clock
    logic clock_100k;
    logic clock_10k;

    //sinais para deserializer
    logic [7:0] data_out_des;
    logic       data_ready_des;
    logic       ack_in;        

    //sinais para queue
    logic [7:0] data_out_queue;
    logic [3:0] len_out_queue;
    logic       status_out_queue;


    clock_divider clk_divider_inst (
        .reset      (reset),
        .clock_1M   (clock_1M),
        .clock_100k (clock_100k),
        .clock_10k  (clock_10k)
    );

    deserializer deserializer_inst (
        .clock_100k  (clock_100k),
        .reset       (reset),
        .data_in     (data_in),
        .write_in    (write_in),
        .ack_in      (ack_in),
        .data_out    (data_out_des),
        .data_ready  (data_ready_des)
    );

    queue queue_inst (
        .data_in    (data_out_des),
        .clock_10k  (clock_10k),
        .reset      (reset),
        .enq_in     (data_ready_des),
        .deq_in     (deq_in),
        .data_out   (data_out_queue),
        .len_out    (len_out_queue),
        .status_out (status_out_queue)
    );

  
    assign ack_in = data_ready_des;

    assign data_out   = data_out_queue;
    assign len_out    = len_out_queue;
    assign status_out = status_out_queue;

endmodule
