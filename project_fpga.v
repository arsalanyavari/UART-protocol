module sender (
    clk,
	send_flag,
    send_data , 
    out_serial_bit,
);
	parameter bowd_rate = 9600 ; 
    parameter clk_pariod = 50;
	input send_flag,clk;
    input [6:0] send_data;
    output reg  out_serial_bit;
    reg [9:0] data_reg;
    integer curent_pos; 
    integer max_clk; 
    integer clk_counter ;
    integer  i;
    integer counter_even;
    // clk generator 
    // always begin
    //     clk = 1'b0;
    //     clk_change = clk_pariod/2;
    //     forever begin
    //         #clk_change clk = ~clk;
    //     end
    // end
    
   
    initial begin
        max_clk = ((1000000000/bowd_rate) / clk_pariod) - 5 ;
        curent_pos= 1 ; 
        clk_counter = -1 ; 
        counter_even = 0 ; 
		out_serial_bit = 1'b1;
    end 
    always @(posedge clk) begin
	if(curent_pos <=9 )
	begin
        if(send_flag == 1'b1)
            begin
                if(clk_counter == -1 )
                begin
				out_serial_bit = 1'b0 ;
                for (i = 1 ; i<=7 ; i= i +1)
                begin
                    if(send_data[i-1] == 1'b1)
                    begin
                      counter_even = counter_even +1;
                    end
                    data_reg [i]= send_data[i-1];

                end
                data_reg[0]= 1'b0;
                data_reg[9]= 1'b1 ;
                if (counter_even/2 == 0 )
                    data_reg[8] = 1'b0;
                else
                    data_reg[8] = 1'b1;
            end
            clk_counter = clk_counter + 1 ; 
            if(max_clk < clk_counter)
            begin
                out_serial_bit = data_reg[curent_pos];
                curent_pos = curent_pos + 1 ;
                clk_counter=0; 
                
            end
            
                
            
        end
    end 
	else 
		out_serial_bit = 1'b1;
    end
endmodule