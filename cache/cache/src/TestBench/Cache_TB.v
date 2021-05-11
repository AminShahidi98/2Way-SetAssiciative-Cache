`timescale 1ns / 1ps
module Cache_tb;
	
	wire [31:0]dout0;
	wire [31:0]dout1;
	reg clk;
	reg sel0;
	reg sel1;
	reg we;
	reg [31:0]addr_in;
	wire HIT0;
	wire HIT1;
	reg [31:0]addr_mem;
	reg [31:0]di0;
	reg [31:0]di1;
	
	initial 
		begin
			clk = 1'b0;
			forever #10 clk = ~clk;
		end	
	
		Cache UUT (
			.dout0(dout0),
			.dout1(dout1),
			.clk(clk),
			.sel0(sel0),
			.sel1(sel1),
			.we(we),
			.addr_in(addr_in),
			.HIT0(HIT0),
			.HIT1(HIT1),
			.addr_mem(addr_mem),
			.di0(di0),
			.di1(di1));
	
	initial
        begin	//dar in qesmat meqdare 15 ra dar khaneye 8om e ram0 mirizim. index=8 word_offset=0 block_offset=0 tag=0 pas bana bar in => addr_in = 256
			we = 1'b1;
			sel0 = 1'b1;
			sel1 = 1'b0;
			addr_in = 256;
			di0 = 15;
			di1 = 0;
            #20;
				//hala khaneye 8 ome cache ra read mikonim. javab dar blocke e ram0 ast. zira dar addrese 8 blocke ram0 dar bala meqdar dadim. 
			we = 1'b0;
			sel0 = 1'b0;
			sel1 = 1'b0;
			addr_in = 256;
			di0 = 0;
			di1 = 0;
            #20;
				 //dar in qesmat meqdare 20 ra dar khaneye 9om e ram1 mirizim. index=9 word_offset=0 block_offset=0 tag=0 pas bana bar in => addr_in = 288
			we = 1'b1;
			sel0 = 1'b0;
			sel1 = 1'b1;
			addr_in = 288;
			di0 = 0;
			di1 = 20;
            #20
				//hala khaneye 9 ome cache ra read mikonim. javab dar blocke e ram1 ast. zira dar addrese 9 blocke ram1 dar bala meqdar dadim. 
			we = 1'b0;
			sel0 = 1'b0;
			sel1 = 1'b0;
			addr_in = 288;
			di0 = 0;
			di1 = 0;
            #20;
        end


endmodule