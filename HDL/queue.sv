module queue(
    input logic [7:0]   data_in,
    input logic         clock_10k,   // clock 10KHZ
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


always @(posedge clock_10k or posedge reset) begin
    if (reset) begin
    data_out    <= 0;
    len_out     <= 0;
    status_out  <= 0;
    head        <= 0;
    tail        <= 0;

        // Zera o vetor
        for (int i = 0; i < 8; i++) begin
            vector[i] <= 0;
        end

        $display("Queue reset. Initial state:");
        $display("[%h] [%h] [%h] [%h] [%h] [%h] [%h] [%h]", 
        vector[0], vector[1], vector[2], vector[3], 
        vector[4], vector[5], vector[6], vector[7]);
        $display("Queue size: %0d", len_out);
        $display("Head: %0d, Tail: %0d", head, tail);  
    end else begin

        status_out <= 0; 

        //enqueue    
        if(enq_in) begin    
            if(len_out < 8) begin //se tem espaço na fila e enq_in ta ativo
                vector[tail] <= data_in;          //coloca o dado na fila
                $display("Enqueue: Put %h in position %0d", data_in, tail);
                tail <= (tail + 1) % 8;           //incrementa tail em 1, se chegar em 8 zera
                len_out <= len_out + 1;
                    // Mostra o vetor inteiro após enqueue
                    $display("Queue status after enqueue:");
                    $display("[%h] [%h] [%h] [%h] [%h] [%h] [%h] [%h]", 
                    vector[0], vector[1], vector[2], vector[3], 
                    vector[4], vector[5], vector[6], vector[7]);
                    $display("Queue size: %0d", len_out);
                    $display("Head: %0d, Tail: %0d", head, tail);  
            end else begin
            status_out <= 1;
                $display("ERROR: Queue FULL! Couldn't place %h", data_in);
                $display("[%h] [%h] [%h] [%h] [%h] [%h] [%h] [%h]", 
                vector[0], vector[1], vector[2], vector[3], 
                vector[4], vector[5], vector[6], vector[7]);
                $display("Queue size: %0d", len_out);
                $display("Head: %0d, Tail: %0d", head, tail);  
            end
        end

        //dequeue
        if(deq_in) begin
            if(len_out > 0) begin //se tem algo para tirar e deq_in ta ativo
                data_out <= vector[head];         //primeiro que entrou
                $display("I removed %h from the position %0d", vector[head], head);
                head <= (head + 1) % 8;           //incrementa head em 1, se chegar em 8 zera
                len_out <= len_out - 1;
                    // Mostra o vetor inteiro após dequeue
                    $display("Queue status after dequeue:");
                    $display("[%h] [%h] [%h] [%h] [%h] [%h] [%h] [%h]", 
                    vector[0], vector[1], vector[2], vector[3], 
                    vector[4], vector[5], vector[6], vector[7]);
                    $display("Queue size: %0d", len_out);
                    $display("Head: %0d, Tail: %0d", head, tail);  
            end else begin
                 $display("ERROR: Nothing to be removed");
            end
        end
    end
end
endmodule