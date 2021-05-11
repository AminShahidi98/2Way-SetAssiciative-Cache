`timescale 1ns/1ps

module Cache ( 
	output [31:0] dout0
	, output [31:0] dout1
	, input clk 
	, input sel0
	, input sel1
	, input we
	, input [31:0] addr_in
	, output HIT0
	, output HIT1
	
	, input [31:0] addr_mem
	
	, input [31:0] di0
	, input [31:0] di1
	);
	
	reg  [277:0] ram0 [0:63];
	reg  [277:0] ram1 [0:63];
	wire [277:0] read_a0 ;
	wire [277:0] read_a1 ;
	wire [20:0] tag_addr, tag_ram_a0, tag_ram_a1;
	wire Valid0;
	wire Valid1;
	reg  [31:0] y;
	reg  [31:0] z;
	wire [2:0] block_a0;
	wire [2:0] block_a1;
	
	assign tag_addr = addr_in[31:11]; // Addres Tag
	assign tag_ram_a0  = read_a0[276:256]; // Ram Tag 0
	assign tag_ram_a1  = read_a1[276:256]; // Ram Tag 1
	assign Valid0       = read_a0[277];
	assign Valid1       = read_a1[277];
	assign HIT0         = (tag_ram_a0==tag_addr)? Valid0:0;
	assign HIT1         = (tag_ram_a1==tag_addr)? Valid1:0;
	assign block_a0    = addr_in[4:2];
	assign block_a1    = addr_in[4:2];
	
	
	always @(posedge clk)
		begin
			if (we & sel0)
				ram0[addr_in[10:5]] <= di0;
		end
		
	always @(posedge clk)
		begin
			if (we & sel1)
				ram1[addr_in[10:5]] <= di1;
		end
	
	assign read_a0 = ram0[addr_in[10:5]];
	assign read_a1 = ram1[addr_in[10:5]];
	
	always @ (read_a0[255:0] or block_a0)
		case (block_a0)
			0: y = read_a0[31:00];
			1: y = read_a0[63:32];
			2: y = read_a0[95:64];
			3: y = read_a0[127:96];
			4: y = read_a0[159:128];
			5: y = read_a0[191:160];
			6: y = read_a0[223:192];
			7: y = read_a0[255:224];
			default: y = 32'b0;
		endcase
	assign dout0= y;
	
	always @ (read_a1[255:0] or block_a1)
		case (block_a1)
			0: z = read_a1[31:00];
			1: z = read_a1[63:32];
			2: z = read_a1[95:64];
			3: z = read_a1[127:96];
			4: z = read_a1[159:128];
			5: z = read_a1[191:160];
			6: z = read_a1[223:192];
			7: z = read_a1[255:224];
			default: z = 32'b0;
		endcase
	assign dout1= z;
	
	
endmodule
