/*

fila:
        - é um container limitado do tipo LIFO de 8 bits;
        - elementos são inserdos através do data_in e enqueue_in;
        - elementos são removidos através do data_out e dequeue_in;
        - o sinal len_out de 8 bits que indica o nº de elementos da fila;
        - quando o sinal dequeue_in sobe, o 1º dado a ser retirado deve aparecer em data_out no próximo ciclo SE o nº de elementos (len_out) for maior que 0.

regras: 
        - A fila possui um tamanho fixo de 8 espaços, cada com 8 bits;
        - O sinal len_out deve informar o número de espaços utilizados;
        - Para colocar um elemento na fila, o elemento deverá aparecer no sinal data_in e o sinal enqueue_in deverá estar alto; 
        - Para remover um elemento da fila, o sinal dequeue_in deve ser levantado e, no ciclo subsequente, o dado removido deverá aparecer no sinal data_out; 
        - Este módulo deverá funcionar a 10KHz.


*/


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
    data_in     <= 0;
    enq_in      <= 0;
    deq_in      <= 0;
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
                data_out <= vector[head]          //primeiro que entrou
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