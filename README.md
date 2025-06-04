# Projeto: Deserializador com Buffer de Fila
Esse projeto implementa um sistema digital composto por dois módulos principais:
1. __Deserializer__ - Recebe dados seriais (bit a bit) e monta um vetor de 8 bits.

| **Sinal**    | **Direção** | **Descrição**                   |
| ------------ | ----------- | ------------------------------- |
| `clock_100`  | Input       | Clock principal de 100KHz       |
| `reset`      | Input       | Reset síncrono                  |
| `data_in`    | Input       | Dados seriais                   |
| `write_in`   | Input       | Pulso para capturar o bit atual |
| `ack_in`     | Input       | Confirmação de leitura do vetor |
| `data_out`   | Output      | Vetor de 8 bits montado         |
| `data_ready` | Output      | Vetor pronto para ser lido      |



2. __Queue (Fila FIFO)__ - Armazena temporariamente o vetor recebido para posterior processamento.
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



3. __Clock_Divider__ - Módulo que recebe um Clock de 1MHz e divive em dois clocks, um de __100KHz__ e outro de __10KHz__.
   Esse módulo usa as variáveis `counter_100K` e `counter_10K` para contar o clock de 1MHz até 10 e até 100, respectivamente. Quando chega nesses valores, os clocks sobem e a contagem reinicia.  
