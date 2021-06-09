`timescale 1ns / 1ps


module uart_rx
//Truyen tham so so databits, so ticks for stop bit
#(parameter DBIT=8, SB_TICK=16)
 (input wire clk, reset,//clk va reset
  input wire rx, s_tick,//rx: bit truyen
  output reg rx_done_tick,//bit tra ve tin hieu da truyen xong
  output wire [7:0] dout //dataout
    );
    
//Khai bao cac ma trang thai
    localparam [1:0]
    idle=2'b00,
    start=2'b01,
    data=2'b10,
    stop=2'b11;

//Khai bao cai tin hieu
reg[1:0] state_reg, state_next; //Thanh ghi trang thai va trang thai tiep
reg[3:0] s_reg, s_next; //dem so tick
reg[2:0] n_reg, n_next;
reg[7:0] b_reg, b_next;//bit truyen

//Cap nhat trang thai sau moi clock
always @(posedge clk, posedge reset)
    if(reset)
        begin 
            state_reg <=idle; //Trang thai ban dau: idle
            s_reg <=0;//S_tick=0
            n_reg <=0;//So biet da truyen
            b_reg <=0;// bit tin hieu truyen
         end
       else
        begin
            state_reg <=state_next;
            s_reg <=s_next;
            n_reg <=n_next;
            b_reg <= b_next;
         end
        
       
always @*
    begin
    //data path funtion, tr?ng thai defaut
        state_next=state_reg;
        rx_done_tick=1'b0;
        s_next=s_reg;
        n_next=n_reg;
        b_next=b_reg;
        
        
        //FSM
        case(state_reg)
        idle:
            if(~rx)
                begin
                    state_next=start;
                    s_next=0;
                  end
          start:
            if(s_tick)//
                if(s_reg==7)//Bo dem 
                    begin
                        state_next=data;
                        s_next=0;
                        n_next=0;
                    end
                else
                    s_next=s_reg +1;
             data:
             if(s_tick)
                if(s_reg==15)
                    begin
                        s_next=0;
                        b_next={rx,b_reg[7:1]};
                        if(n_reg==(DBIT-1))//n_reg=7 thi dung
                            state_next=stop; 
                         else
                            n_next=n_reg+1;
                       end
                    else
                        s_next=s_reg+1;
              stop:
                if(s_tick)
                    if(s_reg==(SB_TICK-1))
                        begin
                            state_next=idle;
                            rx_done_tick=1'b1;
                         end
                      else
                        s_next=s_reg+1;
                    endcase
                    end
                   assign dout=b_reg; 
                        
             
    
      
    
endmodule
