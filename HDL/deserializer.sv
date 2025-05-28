/* deserializador: 
    - recebe uma sequência de 8 bits pelo data_in;
	- escreve palavras de 8 bits no data_out;
	- o sinal status_out indica se o serealizador pode receber dados;
	- o sinal write_in indica que o dado deve ser interpretado pelo deserializador;
	- o fio data_out possui 8 bits e é a saída de dados do deserializador;
	- os dados estão prontos para consumo quando o sinal data_ready está alto;
    - para confirmar o dado recebido o sinal ack_in é escrito.

regras: 
    - O deserializador deve receber 1 bit pelo data_in;
    - Se o sinal write_in estiver alto, o bit recebido deverá ser guardado; 
    - Quando houver 8 bits guardados, o sinal data_ready deverá estar alto e os bits guardados deverão aparecer em data_out, ou seja, existem dados para transmitir;
    - Os valores de data_out e data_ready deverão se manter até o sinal ack_in ficar alto, ou seja, que os dados foram recebidos;
    - Enquanto o deserializador não conseguir enviar os dados, deverá manter o sinal de status_out alto, ou seja, está ocupado;
    - Este módulo deverá funcionar a 100KHz. 
*/

module deserializer(
    input  logic clock,
    input  logic reset,

    input  logic [7:0] data_in,      //entrada de 8 bits
    input  logic [1:0] write_in,
    input  logic [1:0] ack_in,

    output logic [1:0] data_ready,
    output logic [1:0] status_out,
    output logic [7:0] data_out      //saida pacotes de 8 bits

);

logic [3:0] full;

typedef enum {R, G, E  } statetype;
statetype estados;

always_ff @(posedge clock or posedge reset) begin
    if(reset) begin
        data_in <= 0;
        write_in <= 0;
        ack_in <= 0;
        data_ready <= 0;
        status_out <= 1;
        data_out <= 0;
        estados <= R;
    end else begin

        case (estados)

        R: begin
            if (status_out != 0) begin
                
            end
        end 
        endcase

    end





endmodule