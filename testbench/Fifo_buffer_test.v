`timescale 1ns / 1ps

module Fifo_buffer_test();
       localparam T = 20;
       reg wr, rd, clk, reset;
       reg [7:0] data_w;
       wire full, empty;
       wire [7:0] data_r;
       
       Fifo_buffer #(.W(8), .N(2)) DUT(.wr(wr), .rd(rd), .clk(clk), .reset(reset), .data_w(data_w), .full(full), 
                       .empty(empty), .data_r(data_r));
       always
          begin
             clk = 1'b1;
             #(T/2);
             clk = 1'B0;
             #(T/2); 
           end
       
       // ==== initialization ====
       initial
          begin
             reset = 1'b1;
             #(T/2); 
             reset = 1'b0;
             #(T/2);
          end
       // ==== test vector ====
       initial
          begin
             wait(reset == 1'b0); 
             @(negedge clk);
             data_w = 4'b1001;
             // write first
             wr = 1'b1;
             rd = 1'b0;
             repeat(3) @(negedge clk);
             // read
             wr = 1'b0;
             rd = 1'b1;
             repeat(3) @(negedge clk);
             // full test
             rd = 1'b0; 
             wr = 1'b1;
             repeat(5) @(negedge clk);
             // empty test
             rd = 1'b1;
             wr = 1'b0;
             repeat(6) @(negedge clk); 
             // apply both rd and wr
             wr = 1'b1;
             repeat(10) @(negedge clk);
             $finish;
          end
                   
endmodule
