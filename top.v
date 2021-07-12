module top;

reg sender_clk = 1'b0;
reg sender_flag = 1'b1;
reg[6:0] sender_data = 7'b0000000;
wire bit;

reg receiver_clk = 1'b0;
wire [6:0] out_rec;
wire broke;





//integer receiverclock = 60;
//integer senderclock = 50;

defparam r1.clk_length = 60;
defparam s1.clk_pariod = 50;

initial
forever #(s1.clk_pariod/2) sender_clk=~sender_clk;

initial
forever #(r1.clk_length/2) receiver_clk=~receiver_clk;


sender s1(sender_clk, sender_flag, sender_data, bit);
Receiver r1(receiver_clk, bit, out_rec, broke);

endmodule