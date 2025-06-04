//Periodo = 1 / frequencia

// Periodo para 1MHz   -> 1 / 1 000 000 = 1us
// Periodo para 100KHz -> 1 / 100 000   = 10us
// Periodo para 10KHz  -> 1 / 10 000    = 100us

/*
    - A cada 10  Clocks do 1MHz, conta um clock do 100KHz -> mais rápido, menos ciclos (de 1MHz)
    - A cada 100 Clocks do 1MHz, conta um clock do 10KHz  -> mais lento, mais ciclos
*/


module clock_divider(
    input logic reset,
    input logic clock_1M,
    output logic clock_100k,
    output logic clock_10k
);

    logic [3:0] counter_100k; //contador para o 100k (precisa contar até 10)
    logic [6:0] counter_10k;  //contador para o 10k  (precisa contar até 100)

    //clock de 100KHz -> a cada 10 clocks de 1M, conta um desse
    always_ff @(posedge clock_1M or posedge reset) begin
        if(reset) begin
            counter_100k <= 0;
            clock_100k   <= 0;
        end else begin
            if(counter_100k == 4'd9) begin
                clock_100k <= ~clock_100k;  
                counter_100k <= 0;
                //$display("subi o clock_100k");   
            end else begin
                clock_100k <= 0;
                counter_100k <= counter_100k + 1;
                //$display("clock_100k + 1 | %b", counter_100k);
            end
        end
    end

    //clock de 10KHz -> a cada 100 clocks de 1M, conta um desse
    always_ff @(posedge clock_1M or posedge reset) begin
        if(reset) begin
            counter_10k <= 0;
            clock_10k   <= 0;
        end else begin
            if(counter_10k == 7'd99) begin
                clock_10k   <= ~clock_10k;      
                counter_10k <= 0; 
                //$display("subi o clock_10k");  
            end else begin
                clock_10k <= 0;
                counter_10k <= counter_10k + 1;
                //$display("clock_10k  + 1 | %b", counter_10k);
            end
        end
    end
















endmodule
