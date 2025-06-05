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
      #150
      write_in  = 1;
      data_in   = b; #10;            //um clock de 100k
      write_in  = 0;         
    end
  endtask

  task remove_byte();
    begin
      #100
      deq_in   = 1; #100;
      deq_in   = 0; #50;
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


        $display("============================== \n\n > Start of simulation \n\n ==============================");
        

//================================================================================================\\
// Primeira etapa: Colocar e tirar bytes em sequencia.

        $display("Primeira etapa: Colocar e tirar bytes em sequencia\n___________________________________________________");  

        // Byte 1: 00010001 (11)
        $display("\n -> Byte: 00010001 (11)");
        send_bit(0); send_bit(0); send_bit(0); send_bit(1);
        send_bit(0); send_bit(0); send_bit(0); send_bit(1);
        remove_byte();

        // Byte 2: 00100010 (22)
        $display("\n -> Byte: 00100010 (22)");
        send_bit(0); send_bit(0); send_bit(1); send_bit(0);
        send_bit(0); send_bit(0); send_bit(1); send_bit(0);
        remove_byte();

        // Byte 3: 00110011 (33)
        $display("\n -> Byte: 00110011 (33)");
        send_bit(0); send_bit(0); send_bit(1); send_bit(1);
        send_bit(0); send_bit(0); send_bit(1); send_bit(1);
        remove_byte();

        // Byte 4: 01000100 (44)
        $display("\n -> Byte: 01000100 (44)");
        send_bit(0); send_bit(1); send_bit(0); send_bit(0);
        send_bit(0); send_bit(1); send_bit(0); send_bit(0);
        remove_byte();

        // Byte 5: 01010101 (55)
        $display("\n -> Byte: 01010101 (55)");
        send_bit(0); send_bit(1); send_bit(0); send_bit(1);
        send_bit(0); send_bit(1); send_bit(0); send_bit(1);
        remove_byte();

        // Byte 6: 01100110 (66)
        $display("\n -> Byte: 01100110 (66)");
        send_bit(0); send_bit(1); send_bit(1); send_bit(0);
        send_bit(0); send_bit(1); send_bit(1); send_bit(0);
        remove_byte();
        
        // Byte 7: 01110111 (77)
        $display("\n -> Byte: 01110111 (77)");
        send_bit(0); send_bit(1); send_bit(1); send_bit(1);
        send_bit(0); send_bit(1); send_bit(1); send_bit(1);
        remove_byte();

        // Byte 8: 10001000 (88)
        $display("\n -> Byte: 10001000 (88)");
        send_bit(1); send_bit(0); send_bit(0); send_bit(0);
        send_bit(1); send_bit(0); send_bit(0); send_bit(0);
        remove_byte();

  
        // // Byte 9: 10011001 (99)
        // $display("\n -> Byte: 10011001 (99)");
        // send_bit(1); send_bit(0); send_bit(0); send_bit(1);
        // send_bit(1); send_bit(0); send_bit(0); send_bit(1);
        // remove_byte();

//===============================================================================================
//Segunda Etapa: Colocar 8 bytes e tirar 8 bytes.

        $display("Segunda Etapa: Colocar 8 bytes e tirar 8 bytes.\n____________________________________________________");

      
        // Byte 10: 10101010 (aa)
        $display("\n -> Byte: 10101010 (aa)");
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 11: 10111011 (bb)
        $display("\n -> Byte: 10111011 (bb)");
        send_bit(1); send_bit(0); send_bit(1); send_bit(1);
        send_bit(1); send_bit(0); send_bit(1); send_bit(1);

        #150
        // Byte 12: 11001100 (cc)
        $display("\n -> Byte: 11001100 (cc)");
        send_bit(1); send_bit(1); send_bit(0); send_bit(0);
        send_bit(1); send_bit(1); send_bit(0); send_bit(0);

        #150
        // Byte 13: 11011101 (dd)
        $display("\n -> Byte: 11011101 (dd)");
        send_bit(1); send_bit(1); send_bit(0); send_bit(1);
        send_bit(1); send_bit(1); send_bit(0); send_bit(1);

        #150
        // Byte 14: 11101110 (ee)
        $display("\n -> Byte: 11101110 (ee)");
        send_bit(1); send_bit(1); send_bit(1); send_bit(0);
        send_bit(1); send_bit(1); send_bit(1); send_bit(0);
        
        #150
        // Byte 15: 11111111 (ff)   
        $display("\n -> Byte: 11111111 (ff)");
        send_bit(1); send_bit(1); send_bit(1); send_bit(1);
        send_bit(1); send_bit(1); send_bit(1); send_bit(1);

        #150
        // Byte: 10101011 (ab)
        $display("\n -> Byte: 10101011 (ab)");
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);
        send_bit(1); send_bit(0); send_bit(1); send_bit(1);

        #150
        // Byte: 10101100 (ac)
        $display("\n -> Byte: 10101100 (ac)");
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);
        send_bit(1); send_bit(1); send_bit(0); send_bit(0);

        repeat(8) remove_byte();
        

//=======================================================================================
///Terceira Etapa: Tentar colocar mais bytes que permitido na fila

        $display("Terceira Etapa: Tentar colocar mais bytes que permitido na fila\n_________________________________________________________________");

        #200
        // Byte 16: 00011010 (1a)
        $display("\n -> Byte: 00011010 (1a)");
        send_bit(0); send_bit(0); send_bit(0); send_bit(1);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #200
        // Byte 17: 00101010 (2a)
        $display("\n -> Byte: 00101010 (2a)");
        send_bit(0); send_bit(0); send_bit(1); send_bit(0);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 18: 00111010 (3a)
        $display("\n -> Byte: 00111010 (3a)");
        send_bit(0); send_bit(0); send_bit(1); send_bit(1);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 19: 01001010 (4a)
        $display("\n -> Byte: 01001010 (4a)");
        send_bit(0); send_bit(1); send_bit(0); send_bit(0);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 20: 01011010 (5a)
        $display("\n -> Byte: 01011010 (5a)");
        send_bit(0); send_bit(1); send_bit(0); send_bit(1);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 21: 01101010 (6a)
        $display("\n -> Byte: 01101010 (6a)");
        send_bit(0); send_bit(1); send_bit(1); send_bit(0);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 22: 01111010 (7a)
        $display("\n -> Byte: 01111010 (7a)");
        send_bit(0); send_bit(1); send_bit(1); send_bit(1);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #150
        // Byte 23: 10001010 (8a)
        $display("\n -> Byte: 10001010 (8a)");
        send_bit(1); send_bit(0); send_bit(0); send_bit(0);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);


        #150
        // Byte 24: 10011010 (9a)  ->9° byte, a fila deve travar e n deve ser permitido.
        $display("\n -> Byte: 10011010 (9a)");
        send_bit(1); send_bit(0); send_bit(0); send_bit(1);
        send_bit(1); send_bit(0); send_bit(1); send_bit(0);

        #500 

        $stop;
    end
  

endmodule
