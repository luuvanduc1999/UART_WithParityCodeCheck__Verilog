`timescale 1ns / 1ps

module baudrate_generator_test();
          localparam T = 2;
          localparam N = 8;
          reg clk, reset;
          wire s_tick;
          
          baudrate_generator #(.M(163), .N(8)) DUT(.clk(clk), .reset(reset), .s_tick(s_tick));
          
          always
          begin
             clk = 1'b1;
             #(T/2);
             clk = 1'b0;
             #(T/2);
          end
          
          initial
          begin
             reset = 1'b1;
             #(T/2);
             reset = 1'b0;
          end
          
          initial
          begin
             repeat(500) @(negedge clk);
          end
endmodule
