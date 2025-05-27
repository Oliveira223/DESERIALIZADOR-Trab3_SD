# DESERIALIZADOR

deserializador: 
        - recebe uma sequência de 8 bits pelo data_in;
		- escreve palavras de 8 bits no data_out;
		- o sinal status_out indica se o serealizador pode receber dados;
		- o sinal write_in indica que o dado deve interpretado pelo deserializador;
		- o fio data_out possui 8 bits e é a saída de dados do deserializador;
		- os dados estão prontos para consumo quando o sinal data_ready está alto;
        - para confirmar o dado recebido o sinal ack_in é escrito.
		
 Quando o sinal dequeue_in sobe, o primeiro dado a ser retirado da pilha deve aparecer em data_out no ciclo subsequente se o número de
elementos (len_out) for maior que zero.

fila:
        - é um container limitado do tipo LIFO de 8 bits;
        - elementos são inserdos através do data_in e enqueue_in;
        - elementos são removidos através do data_out e dequeue_in;
        - o sinal len_out de 8 bits que indica o nº de elementos da fila;
        - quando o sinal dequeue_in sobe, o 1º dado a ser retirado deve aparecer em data_out no próximo ciclo SE o nº de elementos (len_out) for maior que 0.