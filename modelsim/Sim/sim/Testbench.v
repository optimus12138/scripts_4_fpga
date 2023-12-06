`timescale 1ns/1ns

module Testbench;

reg			sys_clk			;
reg			sys_rst_n		;
reg	[7:0]	uart_tx_data	;
reg 		uart_tx_en		;

//wire 		uart_tx_done	;
wire 		uart_txd 		;

//para 
parameter	integer	BPS		= 'd130_400		;
parameter	integer	CLK_FRE	= 'd50_000_000	;

localparam	integer	BIT_TIME = 'd1_000_000_000 / BPS ;

//(1)
always #10 sys_clk = ~sys_clk ;

//(2)
initial begin
	sys_clk 		<= 1'b0	;
	sys_rst_n 		<= 1'b0	;
	uart_tx_en 		<= 1'b0 ;
	uart_tx_data	<= 8'b0 ;
	#80
	sys_rst_n 		<= 1'b1 ;
	#200
	@(posedge sys_clk);
	uart_tx_en 		<= 1'b1	;
	uart_tx_data	<= 8'b0101_0101	;
	#20
	uart_tx_en 		<= 1'b0 ;
	#(BIT_TIME * 10)
	#200 $stop;
end

//(3)initialization
uart #(
	.BPS			(BPS			),
	.CLK_FRE		(CLK_FRE		)
)
uut(
	.sys_clk		(sys_clk		),
	.sys_rst_n		(sys_rst_n		),	

	.uart_tx_data	(uart_tx_data	),
	.uart_tx_en 	(uart_tx_en 	),
	.uart_tx_done 	(uart_tx_done	),
	.uart_txd 		(uart_txd 		)
);

endmodule 
