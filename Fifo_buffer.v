`timescale 1ns / 1ps

module Fifo_buffer
  #(
       parameter W = 8, // so bit m?i h�ng
                 N = 2 // s? bit ??a ch�
   ) 
   (
       input wire wr, rd, clk, reset,
       input wire [W-1:0] data_w,
       output wire full, empty,
       output wire [W-1:0] data_r    
   );
       //signal declaration
       reg [7:0] array [2**N - 1 : 0];
       reg [N-1:0] r_ptr_reg, r_ptr_next, r_ptr_succ;
       reg [N-1:0] w_ptr_reg, w_ptr_next, w_ptr_succ;
       wire wr_en, r_en;
       reg empty_next, full_next;
       reg empty_reg, full_reg;
       
       // body
       // write operation
       always@(posedge clk)
             if(wr_en)
                array[w_ptr_reg] <= data_w;
       // read  operation
           /*  if(r_en)
                data_r <= array[r_ptr_reg]; */
       assign data_r = array[r_ptr_reg];  
       // note
       assign wr_en =  ~full_reg  & wr;
       /*assign r_en  =  ~empty_reg & rd; */ // cannot be used in case 11
       
       //fifo control logic
       //register for read and write pointers
       always@(posedge clk, posedge reset)
          begin
             if(reset)
                begin
                   r_ptr_reg <= 0;
                   w_ptr_reg <= 0;
                   full_reg <=  1'b0;
                   empty_reg <= 1'b1;
                end
             else 
                begin
                   r_ptr_reg <= r_ptr_next;
                   w_ptr_reg <= w_ptr_next;
                   full_reg <= full_next;
                   empty_reg <= empty_next;
                end
             end
       //register for read and write
       //next state logic
       always @*
          begin
             // keep default value
             r_ptr_next = r_ptr_reg;
             w_ptr_next = w_ptr_reg;
             full_next = full_reg;
             empty_next = empty_reg;
             // increment the pointers
             r_ptr_succ = r_ptr_reg + 1;
             w_ptr_succ = w_ptr_reg + 1;
      
             // read and write case
             case({rd, wr})
               /* 2'b00: begin
                          r_ptr_next = r_ptr_reg;
                          w_ptr_next = w_ptr_reg;
                          full_next  = full_reg;
                          empty_next = empty_reg; 
                       end */
               2'b01:  
                          if(~full_reg) // not full
                             begin
                                w_ptr_next = w_ptr_succ;
                                empty_next = 1'b0;
                                if(w_ptr_next == r_ptr_reg)
                                   full_next = 1'b1;
                               /* else
                                   full_next = 1'b0; */ // not necessary as full_reg will keep its previous value
                              end
                       
              2'b10:   
                          if(~empty_reg)
                             begin
                                r_ptr_next = r_ptr_succ;
                                full_next = 1'b0;
                                if(r_ptr_next == w_ptr_reg)
                                   empty_next = 1'b1;
                            /*    else
                                    empty_next = 1'b1; */
                              end
                       
              2'b11:   begin
                          r_ptr_next = r_ptr_succ;
                          w_ptr_next = w_ptr_succ;
                       end
           endcase
         end
       //output    
       assign empty = empty_reg;
       assign full  = full_reg;     
endmodule
