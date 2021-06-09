
module top_uart_tb();
    // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      localparam DBIT = 8,     // # data bits
                SB_TICK = 16, // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
                DVSR = 163,   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
                DVSR_BIT = 8, // # bits of DVSR
                FIFO_W = 2,    // # addr bits of FIFO
                T = 20;              // # words in FIFO=2^FIFO_W
   
   
     reg clk, reset;
     reg rd_uart, wr_uart, rx;
     reg [7:0] w_data;
     wire tx_full, rx_empty, tx;
     wire [7:0] r_data;
   
     top_uart DUT(.clk(clk), .reset(reset), .rd_uart(rd_uart), .wr_uart(wr_uart), .rx(rx),
                  .w_data(w_data), .tx_full(tx_full), .rx_empty(rx_empty), .tx(tx), .r_data(r_data));
                  
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
       #(T/2);
  end
  
     initial
     begin
       rd_uart = 1'b1;
       wr_uart = 1'b0;
       w_data = 8'b11100101;
       #(20);
       wr_uart = 1'b1;
       #(20);
       w_data = 8'b10010101;
       #(20);
       w_data = 8'b11001110;
       #(20);
       w_data = 8'b1010110;
       #(20);
       repeat(100000) @(negedge clk);
       
  end
       
     
      
   


  

endmodule

