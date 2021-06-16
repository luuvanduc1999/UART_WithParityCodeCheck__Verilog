`timescale 1ns / 1ps

module baudrate_generator
    #(  
          parameter N = 8,
                    M = 163       
     )
    (
          input wire clk, reset,
          output wire s_tick
    );

 reg  [N-1:0] r_reg,r_next;
 
 always@(posedge clk, posedge reset)
 begin
    if(reset)
       r_reg <= 8'b0;
    else
       r_reg <= r_next;
 end

always @*
begin
   if(r_reg <= M)
      r_next = r_reg + 1;
   else 
      r_next = 0;
end

assign s_tick = (r_reg == (M)) ? 1'b1 : 1'b0;


endmodule
