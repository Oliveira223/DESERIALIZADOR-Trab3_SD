module deserializer_tb;

  logic clock_100;
  logic reset;
  logic data_in;
  logic write_in;
  logic ack_in;
  logic [7:0] data_out;
  logic data_ready;

  deserializer dut (
    .clock_100(clock_100),
    .reset(reset),
    .data_in(data_in),
    .write_in(write_in),
    .ack_in(ack_in),
    .data_out(data_out),
    .data_ready(data_ready)
  );

  always #5 clock_100 = ~clock_100;  // clock 100kHz

  initial begin
    clock_100 = 0;
    data_in = 0;
    write_in = 0;
    ack_in = 0;
    reset = 1;

    #10;

    reset = 0;

    // enviar 8 bits: 10101101 (0xAD)
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);
    send_bit(0);
    send_bit(1);

  
    #20;

    ack_in = 1;
    #10;
    ack_in = 0;

    #20;

    $stop;
  end

  task send_bit(input logic bit_val);
    begin
      @(posedge clock_100);
      data_in = bit_val;
      write_in = 1;
      @(posedge clock_100);
      write_in = 0;
    end
  endtask

endmodule
