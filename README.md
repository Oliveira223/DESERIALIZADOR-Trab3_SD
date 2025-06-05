# Projeto: Deserializador com Buffer de Fila
Esse projeto implementa um sistema digital composto por quatro módulos, sendo um deles o __top_module__, feito exclusivamente para ligar as entradas e saíads entre os modulos:
### 1. __Deserializer__ - Recebe dados seriais (bit a bit) e monta um vetor de 8 bits.

| **Sinal**    | **Direção** | **Descrição**                   |
| ------------ | ----------- | ------------------------------- |
| `clock_100`  | Input       | Clock principal de 100KHz       |
| `reset`      | Input       | Reset síncrono                  |
| `data_in`    | Input       | Dados seriais                   |
| `write_in`   | Input       | Pulso para capturar o bit atual |
| `ack_in`     | Input       | Confirmação de leitura da queue |
| `data_out`   | Output      | Vetor de 8 bits montado         |
| `data_ready` | Output      | Vetor pronto para ser lido      |



### 2. __Queue (Fila FIFO)__ - Armazena temporariamente o vetor recebido para posterior processamento.
O sistema é projetado para aplicações onde dados seriais precisam ser organizados em pacotes de 8 bits e processados de forma assíncrona.

| **Sinal**    | **Direção** | **Descrição**                   |
| ------------ | ----------- | ------------------------------- |
| `clock_10K`  | Input       | Clock principal de 10KHz        |
| `reset`      | Input       | Reset sincrono                  | 
| `data_in`    | Imput       | Dados vetoriais                 |
| `enq_in`     | Imput       | Flag para permitir data_in      |
| `deq_in`     | Imput       | Flag para permitir dequeue      |
| `data_out`   | Output      | Vetor removido da fila          |
| `len_out`    | Output      | Conta o tamanho da fila         | 
| `ack_in_q`   | Output      | Diz se já leu o valor           |

#### Funcionamento
- Ao receber enq_in, o dado presente em data_in é enfileirado.
- Ao receber deq_in, o dado mais antigo é removido e entregue em data_out.
- O sinal len_out indica quantos elementos estão presentes na fila no momento.


### 3. __Clock_Divider__ - Módulo que recebe um Clock de 1MHz e divive em dois clocks, um de __100KHz__ e outro de __10KHz__.
   Esse módulo usa as variáveis `counter_100K` e `counter_10K` para contar o clock de 1MHz até 10 e até 100, respectivamente. Quando chega nesses valores, os clocks sobem e a contagem reinicia.  

| **Sinal**    | **Direção** | **Descrição**               |
| ------------ | ----------- | --------------------------- |
| `clock_in`   | Input       | Clock principal de 1 MHz    |
| `reset`      | Input       | Reset síncrono              |
| `clock_100K` | Output      | Clock dividido para 100 KHz |
| `clock_10K`  | Output      | Clock dividido para  10 KHz |

#### Funcionamento

- Periodo = 1 / frequencia.
- Periodo para 1MHz   -> 1 / 1 000 000 = 1us.
- Periodo para 100KHz -> 1 / 100 000   = 10us.
- Periodo para 10KHz  -> 1 / 10 000    = 100us.
- A cada 10  Clocks do 1MHz, conta um clock do 100KHz -> mais rápido, menos ciclos (de 1MHz).
- A cada 100 Clocks do 1MHz, conta um clock do 10KHz  -> mais lento, mais ciclos.

### 4. __Top_Module__ - Módulo que junta todos os módulos para funcionarem sincronizados.

| **Sinal**    | **Direção** | **Descrição**                               |  
| ------------ | ----------- | ------------------------------------------- |
| `clock_1_ M `|  Input      |  Clock principal de 1MHz                    |   
| `reset`      |  Input      |  Reset síncrono                             |
| `data_in`    |  Input      |  Entrada serial (1 bit)                     |
| `write_in`   |  Input      |  Validador do data_in por ciclo             | 
| `deq_in`     |  Input      |  Sinal de "dequeue" para a fila             | 
| `data_out`   |  Output     |  Vetor retirado da fila                     | 
| `len_out`    |  Output     |  Quantidade de elementos atualmente na fila | 
| `status_out` |  Output     |  Flag de erro de fila cheia/vazia           |









