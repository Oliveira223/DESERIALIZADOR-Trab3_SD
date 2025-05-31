# Projeto: Deserializador com Buffer de Fila
Esse projeto implementa um sistema digital composto por dois módulos principais:
1. __Deserializer__ - Recebe dados seriais (bit a bit) e monta um vetor de 8 bits.
2. __Queue (Fila FIFO)__ - Armazena temporariamente o vetor recebido para posterior processamento.
O sistema é projetado para aplicações onde dados seriais precisam ser organizados em pacotes de 8 bits e processados de forma assíncrona.

## Deserializer
| **Sinal**    | **Direção** | **Descrição**                   |
| ------------ | ----------- | ------------------------------- |
| `clock_100`  | Input       | Clock principal                 |
| `reset`      | Input       | Reset síncrono                  |
| `data_in`    | Input       | Dados seriais                   |
| `write_in`   | Input       | Pulso para capturar o bit atual |
| `ack_in`     | Input       | Confirmação de leitura do vetor |
| `data_out`   | Output      | Vetor de 8 bits montado         |
| `data_ready` | Output      | Vetor pronto para ser lido      |

### Como funciona:
- Recebe bits na borda de subida do clock apenas quando `write_in` está ativo.
- Quando o vetor chega em 8 bits, o sinal `data_ready` sobe, indicando que o vetor está pronto.
- Aguarda o sinal `ack_in` para limpar o vetor e começar um novo vetor.

## Queue 
| **Sinal**  | **Direção** | **Descrição**            |
| ---------- | ----------- | ------------------------ |
| `clock_10` | Input       | Clock                    |

... completar ...
