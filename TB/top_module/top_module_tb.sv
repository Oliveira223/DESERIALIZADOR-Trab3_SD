`timescale 1us/1ns

module top_module_tb;

    //––– Entradas do DUT ––––––––––––––––––––––––––––––––––––––––––––––––––––––
    logic        clock_1M;
    logic        reset;
    logic        data_in;
    logic        write_in;
    logic        deq_in;

    //––– Saídas do DUT ––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    logic [7:0]  data_out;
    logic [3:0]  len_out;
    logic        status_out;

    //––– Instancia o DUT –––––––––––––––––––––––––––––––––––––––––––––––––––––
    top_module DUT (
        .clock_1M   (clock_1M),
        .reset      (reset),
        .data_in    (data_in),
        .write_in   (write_in),
        .deq_in     (deq_in),
        .data_out   (data_out),
        .len_out    (len_out),
        .status_out (status_out)
    );


   task send_bit(input logic b);
    begin
    write_in = 1;
    data_in = b;
    #10;
    write_in = 0;
    #10;
  end
endtask

     initial clock_1M = 0;
    always #0.5 clock_1M = ~clock_1M;

    initial begin
        reset = 1; 
        data_in = 0; 
        write_in = 0; 
        deq_in = 0;
        #5;
        reset = 0;
        #50; 


        $display("======================= \n\n Start of simulation \n\n =======================");
        
        
        // Byte 1: 10101010  (bit sincrono com clock)
        $display("\n -> Primero Byte: 10101010 (aa)");
        write_in = 1;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        write_in = 0; #50;

      // Byte 2: 01010101 (usando task)
      $display("\n -> Segundo Byte: 01010101 (55)");
      send_bit(0);
      send_bit(1);
      send_bit(0);
      send_bit(1);
      send_bit(0);
      send_bit(1);
      send_bit(0);
      send_bit(1);

      #50;

      // Byte 3: 11001100
      $display("\n -> Terceiro Byte: 11001100 (cc)");
      send_bit(1);
      send_bit(1);
      send_bit(0);
      send_bit(0);
      send_bit(1);
      send_bit(1);
      send_bit(0);
      send_bit(0);


        // tira 1 bytes
        deq_in = 1; #15;
        deq_in = 0; #50;

        #1000;
        $stop;
    end
  

endmodule
