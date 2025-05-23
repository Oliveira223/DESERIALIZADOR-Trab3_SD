module deserializer(
    input  logic      clock,
    input  logic      reset,
    input  logic      data_in,
    input  logic      write_in,
    output logic      data_ready,
    output logic      status_out,
    output logic[7:0] data_out
);


always_ff @(posedge clock or posedge reset) begin
    if(reset) begin
        





end





endmodule