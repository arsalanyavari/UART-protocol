module reciever (
    clk,
    recieve_bit,
    out,
    broken

);
    input clk;
    input wire recieve_bit;
    reg recieve_flag, parity, end_bit, start_bit;
    reg [6:0] packet; //paralel data output
    output reg [6:0] out;
    output reg broken;
    integer cnt; //cnt is counter
    integer i; //using for loops
    integer max_clk;
	parameter bowd_rate = 9600 ; 
    parameter clk_length = 60;
    integer clk_cnt;
    integer sum;
    initial begin
		
        max_clk = ((1000000000/bowd_rate) / clk_length);
        cnt = 0;
        recieve_flag =1'b0;
        clk_cnt = 0;
        sum = 0;
        broken = 0;
    end
    
    always @(posedge clk) begin
        start_bit = recieve_bit;
        if(start_bit == 1'b0)
        begin
            recieve_flag = 1'b1;
        end
        if (recieve_flag == 1'b1) begin
            if(clk_cnt >= max_clk)
            begin
            if(cnt==7)
            begin
                parity = recieve_bit;
                clk_cnt = 0;
            end
            else if(cnt == 8)
            begin
                end_bit = recieve_bit;
                for(i = 0; i < 7; i = i + 1)
                    if(packet[i] == 1'b1)
                        sum = sum + 1;
                if(parity == 1'b1)
                    sum = sum + 1;
                if(sum%2 == 0)
                begin
                    for(i = 0; i < 7; i = i + 1)
                        out[i] = packet[i];
                end
                else
                    broken = 1'b1;
                clk_cnt =0;
                recieve_flag = 1'b0;
            end
            else
            begin
                packet[cnt] = recieve_bit;
                clk_cnt = 0;
                cnt = cnt+1;
            end
            end
        clk_cnt = clk_cnt + 1;
        end 
    end
endmodule