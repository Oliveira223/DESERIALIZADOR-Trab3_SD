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
    logic       ack_in_q;             //sinal interno, tipo um handshake que fica trocando info da queue com o deserialziador       

    //sinais para queue
    logic [7:0] data_out_queue;
    logic [3:0] len_out_queue;
    logic       status_out_queue;
    


    clock_divider clk_divider_inst (
        //input
        .reset      (reset),
        .clock_1M   (clock_1M),

        //output
        .clock_100k (clock_100k),
        .clock_10k  (clock_10k)
    );

    deserializer deserializer_inst (
        //input
        .clock_100k  (clock_100k),
        .reset       (reset),
        .data_in     (data_in),
        .write_in    (write_in),
        .ack_in      (ack_in_q),            //input, se ativo, pode mandar mais bytes

        //output
        .data_out    (data_out_des),        //saida de 7 bits pronta
        .data_ready  (data_ready_des)       //indica que a saida tá pronta (zera quando identifica recebe ack_in)
    );

    queue queue_inst (
        //input
        .data_in    (data_out_des),
        .clock_10k  (clock_10k),
        .reset      (reset),
        .enq_in     (data_ready_des),     //flag para colocar na fila -> tem algo? -> if(data_ready) do deserializador
        .deq_in     (deq_in), 

        //output     
        .data_out   (data_out_queue),     //byte da fila
        .len_out    (len_out_queue),
        .ack_in_q   (ack_in_q),             //output que vai para o ack_in do des
        .status_out (status_out_queue)
    );

  
    assign data_out   = data_out_queue;
    assign len_out    = len_out_queue;
    assign status_out = status_out_queue;

endmodule
