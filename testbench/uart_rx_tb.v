`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 02:55:46 AM
// Design Name: 
// Module Name: uart_rx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_rx_tb();
    parameter DBIT=8, SB_TICK=16;
    reg clk=0, reset;
    reg rx, s_tick;
    wire rx_done_tick;
    wire check_parity;
    //wire [7:0] w_data;
    //task UART_WRITE_BYTE;
        //input [7:0] i_Data;
       // interger i
    uart_rx DUT_UART_RX(.clk(clk), .reset(reset),.rx(rx),.s_tick(s_tick),.check_parity(check_parity),.rx_done_tick(rx_done_tick));
    always #1 clk=~clk;
    initial
    begin
       reset = 1'b1;
       #1;
       reset = 1'b0;
       #1;
    end
    initial
        begin
            
             rx=1;  
             repeat(2) @(negedge clk); 
             rx= 0; 
             @(negedge clk);
             s_tick=0;
             @(negedge clk);
             s_tick=1;  
             repeat(15)@(negedge clk); 
             rx=1'b1; 
             repeat(16)@(negedge clk); 
             rx=1'b0; 
             repeat(16)@(negedge clk); 
             rx=1'b1;
             repeat(16)@(negedge clk); 
             rx=1'b0;
              repeat(16)@(negedge clk); 
             rx=1'b1; 
             repeat(16)@(negedge clk); 
             rx=1'b0; 
             repeat(16)@(negedge clk); 
             rx=1'b0;
              repeat(16)@(negedge clk); 
             rx=1'b1; 
             repeat(15)@(negedge clk); 
             rx=1'b1; 
             repeat(17)@(negedge clk); 
             rx=1'b1;
             repeat(45)@(negedge clk); 
            $stop;
        end
               
   
endmodule
