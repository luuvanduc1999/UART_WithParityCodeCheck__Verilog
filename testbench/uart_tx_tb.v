`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2021 04:35:47 PM
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb();
    localparam T = 4;
    parameter DBIT=8, SB_TICK = 16;
    reg clk, reset;
    reg tx_start, s_tick;
    reg [7:0] din;
    wire tx_done_tick;
    wire tx;
    
    uart_tx  dut(.din(din), .clk(clk), .reset(reset), .tx_start(tx_start), .s_tick(s_tick), .tx_done_tick(tx_done_tick), .tx(tx));
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
        din = 8'b10110101;
        tx_start=0;
        repeat(3) @(negedge clk);
        tx_start=1;
        
//       din = 8'b10110111;
        @(negedge clk);
        s_tick=0;
        repeat(10) @(negedge clk);
        
        #200
        din= 8'b11100111;
        tx_start = 1;
        @(negedge clk);
        s_tick=1;
        
        #200
        din= 8'b11100011;
        tx_start = 1;
        @(negedge clk);
        s_tick=1;
        
    end
    
endmodule

