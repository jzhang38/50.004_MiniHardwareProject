/*
   This file was generated automatically by Alchitry Labs version 1.2.0.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module incrementer_1 (
    input clk,
    input rst,
    output reg [2:0] signal,
    output reg [1:0] led_sum,
    input s,
    input cout,
    output reg result_indicator,
    input mode,
    input [2:0] manual
  );
  
  
  
  reg [2:0] M_signal_register_d, M_signal_register_q = 1'h0;
  
  reg M_right_out_false_d, M_right_out_false_q = 1'h1;
  
  reg [2:0] M_register_d, M_register_q = 1'h0;
  
  wire [1-1:0] M_threeBitsAdder_cout;
  wire [3-1:0] M_threeBitsAdder_s;
  reg [3-1:0] M_threeBitsAdder_x;
  reg [3-1:0] M_threeBitsAdder_y;
  reg [1-1:0] M_threeBitsAdder_cin;
  three_bits_adder_3 threeBitsAdder (
    .x(M_threeBitsAdder_x),
    .y(M_threeBitsAdder_y),
    .cin(M_threeBitsAdder_cin),
    .cout(M_threeBitsAdder_cout),
    .s(M_threeBitsAdder_s)
  );
  
  wire [1-1:0] M_slowClock_value;
  counter_4 slowClock (
    .clk(clk),
    .rst(rst),
    .value(M_slowClock_value)
  );
  
  wire [1-1:0] M_slowClockEdge_out;
  reg [1-1:0] M_slowClockEdge_in;
  edge_detector_5 slowClockEdge (
    .clk(clk),
    .in(M_slowClockEdge_in),
    .out(M_slowClockEdge_out)
  );
  
  wire [1-1:0] M_fullAdder_s;
  wire [1-1:0] M_fullAdder_cout;
  reg [1-1:0] M_fullAdder_cin;
  reg [1-1:0] M_fullAdder_x;
  reg [1-1:0] M_fullAdder_y;
  full_adder_6 fullAdder (
    .cin(M_fullAdder_cin),
    .x(M_fullAdder_x),
    .y(M_fullAdder_y),
    .s(M_fullAdder_s),
    .cout(M_fullAdder_cout)
  );
  
  wire [(2'h3+0)-1:0] M_manual_input_out;
  reg [(2'h3+0)-1:0] M_manual_input_in;
  
  genvar GEN_manual_input0;
  generate
  for (GEN_manual_input0=0;GEN_manual_input0<2'h3;GEN_manual_input0=GEN_manual_input0+1) begin: manual_input_gen_0
    button_conditioner_7 manual_input (
      .clk(clk),
      .in(M_manual_input_in[GEN_manual_input0*(1)+(1)-1-:(1)]),
      .out(M_manual_input_out[GEN_manual_input0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  always @* begin
    M_signal_register_d = M_signal_register_q;
    M_right_out_false_d = M_right_out_false_q;
    M_register_d = M_register_q;
    
    M_manual_input_in = manual;
    M_slowClockEdge_in = M_slowClock_value;
    M_threeBitsAdder_x = M_register_q;
    M_threeBitsAdder_y = 8'h01;
    M_threeBitsAdder_cin = 1'h0;
    if (M_slowClockEdge_out == 1'h1 & M_fullAdder_s == s & M_fullAdder_cout == cout) begin
      M_register_d = M_threeBitsAdder_s;
    end
    if (mode == 1'h1 && M_right_out_false_q == 1'h1) begin
      M_signal_register_d = M_threeBitsAdder_s;
    end else begin
      if (mode == 1'h0 && M_right_out_false_q == 1'h1) begin
        M_signal_register_d = M_manual_input_out;
      end
    end
    signal = M_signal_register_q;
    M_fullAdder_x = M_signal_register_q[0+0-:1];
    M_fullAdder_y = M_signal_register_q[1+0-:1];
    M_fullAdder_cin = M_signal_register_q[2+0-:1];
    led_sum[0+0-:1] = M_fullAdder_s;
    led_sum[1+0-:1] = M_fullAdder_cout;
    if (M_slowClockEdge_out == 1'h1 & !(M_fullAdder_s == s & M_fullAdder_cout == cout)) begin
      M_right_out_false_d = 1'h0;
    end
    result_indicator = M_right_out_false_q;
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_right_out_false_q <= 1'h1;
    end else begin
      M_right_out_false_q <= M_right_out_false_d;
    end
  end
  
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_register_q <= 1'h0;
    end else begin
      M_register_q <= M_register_d;
    end
  end
  
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_signal_register_q <= 1'h0;
    end else begin
      M_signal_register_q <= M_signal_register_d;
    end
  end
  
endmodule
