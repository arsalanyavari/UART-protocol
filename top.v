module top;

reg sender_clk = 1`b0;
reg sender_flag = 1`b1;
reg sender_data[6:0] = 7`b;
wire bit;

reg receiver_clk = 1`b0;
wire [6:0] out_rec;
wire broke;


sender s1(sender_clk, sender_flag, sender_data, bit);
Receiver r1(receiver_clk, bit, out_rec, broke);


integer receiverclock = 60;
integer senderclock = 50;

defparam r1.clk_length = receiverclock;
defparam s1.clk_pariod = senderclock;

initial
forever #(senderclock/2) sender_clk=~sender_clk;

initial
forever #(receiverclock/2) receiver_clk=!receiver_clk;