# Projeto: Deserializador com Buffer de Fila
Esse projeto implementa um sistema digital composto por quatro módulos, sendo um deles o __top_module__, feito exclusivamente para ligar as entradas e saíads entre os modulos:

## Módulos
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


### Funcionamento 
- O deserializador recebe 1 bit pelo data_in, se o status out estiver alto;
- Se o sinal write_in estiver alto, o bit recebido é guardado; 
- Quando 8 bits (1 byte) forem guardados, o sinal data_ready fica alto e os bits guardados vão para o data_out;
- Os valores de data_out e data_ready são mantidos até o sinal ack_in ficar alto, ou seja, os dados foram recebidos;
- Enquanto o deserializador não conseguir enviar os dados, deverá manter o sinal de status_out alto, ou seja, está ocupado;
 


### 2. __Queue (Fila FIFO)__ - Armazena temporariamente o vetor recebido para posterior processamento.
O sistema é projetado para aplicações onde dados seriais precisam ser organizados em pacotes de 8 bits e processados de forma assíncrona. Esse módulo usa uma fila circular, quando recebe um byte, incrementa mais 1 à `tail`, quando retira um byte, incrementa `head` em mais 1 (apenas se existia um byte a ser removido). 

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
Se o periodo é igual a 1 / frequencia, então:
- Periodo para 1MHz   -> 1 / 1 000 000 = 1us.
- Periodo para 100KHz -> 1 / 100 000   = 10us.
- Periodo para 10KHz  -> 1 / 10 000    = 100us.

Ou seja,
- A cada 10  Clocks do 1MHz, conta um clock do 100KHz -> mais rápido, menos ciclos (de 1MHz).
- A cada 100 Clocks do 1MHz, conta um clock do 10KHz  -> mais lento, mais ciclos.

### 4. __Top_Module__ - Módulo que conecta todos os módulos para funcionarem sincronizados.

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

## Como funciona
   O __top_module__ recebe os sinais `Clock_1M`, `Reset`,  `data_in`, `write_in` e `deq_in`. 
   
   O `clock_1M` vai diretamente para o modulo __clock_divider__ onde é divido em um clock de 100KHz e um de 10KHz, os quais vão para o módulo __deserializer__ e __queue__, respectivamente. 

   Os bits são enviados para o __deserializer__ de maneira serial por meio do input `data_in` juntamente com a flag `write_in` (responsável por observar se o dado pode ser enviado), os quais são processados dentro do módulo e viram uma saída de 8 bits (1 byte). Esse byte vai diretamente para o módulo __queue__ por meio da entrada `data_in`, dentro do módulo, onde é processado para entrar em um container com 8 espaços - a fila -. Dentro da fila, os elementos são contados utilizando o sinal `len_out`, se o container estiver cheio, ou seja, `len_out` = 8, o módulo é responsável por mandar um sinal para o __deserializer__, avisando que não consegue mais receber bytes (ativando a flag `status_out`), ou seja, o __deserializador__ deve parar de entregar bits (abaixando a flag `write_in`).

   Quando o sinal, `deq_in` é ativo no __top_module__, o módulo __queue__ é responsável por fazer com que o byte mais antigo vá para a saída `data_out`, entregando por fim, os sinais (que antes chegavam de forma serial) agrupados em pacotes de 8 bits. 

## Como simular
Para simular os módulos individualmente, entre na pasta `TB/(módulo desejado)` e então utilize o comando `dp sim.do` para simular. Caso queira testar o projeto completo, entre na pasta `TB/top_module` e utilize o comando `do sim.do` para simular. Todos os módulos estão devidamente comentados no terminal, você poderá ver como os sinais entram, são processados e saem. No `top_module`, também poderá ver os testes de casos e bons e ruins, onde o __deserializer__ e a __queue__ podem travar ou apresentar mensagens de erros (esperadas, é claro). 








