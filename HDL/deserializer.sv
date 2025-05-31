module deserializer(
    input  logic clock_100,
    input  logic reset,

    input  logic data_in,           //entrada de bit em bit
    input  logic write_in,          //flag para ...
    input  logic ack_in,            //flag para ...

    output logic [7:0] data_out,    //saida de 8 bits
    output logic data_ready         //flag para ...
);

    logic status_out;

typedef enum logic [1:0] {
    IDLE,
    RECEIVING,
    READY
  } state_t;

  state_t state;

  logic [3:0] count;        //Conta bits até 8
  logic [7:0] tmp_vector;   //Vetor temporario que enviara os dados completos para data_out em seguida, para evitar problemas

    always @(posedge clock_100 or posedge reset) begin
        if(reset) begin
          state <= IDLE;
          tmp_vector <= 8'b0;
          count <= 4'b0;
          data_out <= 8'b0;
          data_ready <= 0;
          status_out <= 0;
        end else begin
            case(state)
                //Estado parado, esperando o write_in
                IDLE: begin
                    $display("Entrei no estado IDLE");
                    data_ready <= 0;
                    status_out <= 0;

                    //tem que ter a logica igual aqui dentro para não perder o primeiro bit (por causa do clock), ou seja, essa logica abaixo só acontece uma vez (salvando o primeiro bit).
                    if(write_in) begin
                        $display("Write_in ativo");
                        tmp_vector <= {tmp_vector[6:0], data_in}; //tmp_vector[6:0] faz o shift left e então recebe o novo bit
                        $display("tmp_vector = %b", tmp_vector);
                        $display("Recebi o bit %b", data_in);
                        count <= count + 1;
                        state <= RECEIVING;
                    end
                end

                RECEIVING: begin
                    $display("Entrei no estado RECEIVING");
                    status_out <= 1; //ocupado recebendo dados
                    //agora pega os demais bits
                    if(write_in) begin
                        tmp_vector <= {tmp_vector[6:0], data_in}; 
                        $display("tmp_vector = %b", tmp_vector);
                        $display("Recebi o bit %b", data_in);
                        count <= count + 1;
                    end

                    //quando chegar no 7° ele vai fazer mais um shift para evitar perder dados, porém diretamente no data_out 
                    if(count == 7 && write_in) begin
                        // Aqui acontece a passagem para fila -------
                        data_out <= {tmp_vector[6:0], data_in}; 
                        $display("data_out = %b", {tmp_vector[6:0], data_in});
                        $display("Cheguei em 8 bits");
                        $display("data_ready <= 1");
                        data_ready <= 1;   //to pronto pra ir pra fila
                        // -------------------------------------------
                        state <= READY;
                    end
                end

                READY: begin
                    $display("Entrei no estado READY");
                    if(ack_in) begin
                        $display("Ack_in ativo");
                        data_ready <= 0;
                        status_out <= 0;
                        tmp_vector <= 8'b0;
                        count <= 0;
                        data_out <= 8'b0;
                        state <= IDLE;
                    end
                    else begin
                        $display("Ack_in não ativo");
                        status_out <= 1;
                        state <= READY;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule