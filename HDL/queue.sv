module queue(
    input logic [7:0]   data_in,
    input logic         clock_10,   // clock 10KHZ
    input logic         reset,

    input logic         enq_in,
    input logic         deq_in,

    output logic [7:0]  data_out,
    output logic [3:0]  len_out,    //tamanho
    output logic        status_out
);

    logic [7:0] vector[7:0]; // fila de 8 elementos, cada elemento com 8 bits
    logic [2:0] head;        // tamanho até 8
    logic [2:0] tail;        // tamanho até 8


always @(posedge clock_10 or posedge reset) begin
    if (reset) begin
    data_out    <= 0;
    len_out     <= 0;
    end else begin

        //enqueue    
        if(enq_in) begin    
            if(len_out < 8) begin //se tem espaço na fila e enq_in ta ativo
                vector[tail] <= data_in;          //coloca o dado na fila
                $display("Enqueue: Coloquei %h na posição %0d", data_in, tail);
                tail <= (tail + 1) % 8;           //incrementa tail em 1, se chegar em 8 zera
                len_out <= len_out + 1;
                    // Mostra o vetor inteiro após enqueue
                    $display("Estado da fila após enqueue:");
                    $display("[%h] [%h] [%h] [%h] [%h] [%h] [%h] [%h]", 
                    vector[0], vector[1], vector[2], vector[3], 
                    vector[4], vector[5], vector[6], vector[7]);
            end else begin
            status_out <= 1;
            $display("ERRO: Fila CHEIA! Não consegui colocar %h", data_in);
            end
        end

        //dequeue
        if(deq_in) begin
            if(len_out > 0) begin //se tem algo para tirar e deq_in ta ativo
                data_out <= vector[head];         //primeiro que entrou
                $display("Dequeue: Retirei %h da posição %0d", vector[head], head);
                head <= (head + 1) % 8;           //incrementa head em 1, se chegar em 8 zera
                len_out <= len_out - 1;
                    // Mostra o vetor inteiro após dequeue
                    $display("Estado da fila após dequeue:");
                    $display("[%h] [%h] [%h] [%h] [%h] [%h] [%h] [%h]", 
                    vector[0], vector[1], vector[2], vector[3], 
                    vector[4], vector[5], vector[6], vector[7]);
            end else begin
                 $display("ERRO: Nada a ser retirado");
            end
        end
    end
end
endmodule