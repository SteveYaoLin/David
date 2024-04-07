//top_tb
//
`timescale 1ns / 100ps
module top_tb();
//=================================
//---------------------------------
//1 input
reg     clk;
reg     rst_n;
reg     key_touch;
//=================================
//2 output
wire    led;
//3 initial
initial 
begin
    key_touch = 1'b0;
end
//--------------user-defined-------------------
integer i;
//=================================
//3 instantiation of the src

led_ctrl_fsm_Mealy2_two_segment uut
(
    //basic item
    .clk        (clk)           ,
    .rst_n      (rst_n)         ,
    //led_ctrl interface
    .key_touch  (key_touch)     ,
    .led        (led)
);
//=================================
//4 clk
initial 
begin
    clk = 1'b0;
end
parameter   CLK50M_PERIOD = 20;
always #(CLK50M_PERIOD/2) clk = (~clk);
//=================================
//4 initial
initial
begin
    repeat(10) @(posedge clk);
    for(i=0;i<1024;i=i+1)
    begin
        repeat(5) @(posedge clk);
        @(posedge clk) key_touch <= 1'b1;
        @(posedge clk) key_touch <= 1'b0;
    end
end
//=================================
initial 
begin
    reset;
end
//=================================
//5 task helper
task reset;
    rst_n = 1'b0;
    #122 rst_n = 1'b1;
endtask
//=================================
endmodule