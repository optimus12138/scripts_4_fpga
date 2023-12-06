module uart
#(
	parameter	integer BPS		=9_600,				//baud rate
	parameter	integer CLK_FRE	=50_000_000			//main clock frequency
)
(
	//system interfaces
	input			sys_clk			,				//system clock
	input			sys_rst_n		,				//system reset,
	//user interfaces
	input	[7:0]	uart_tx_data	,				//data
	input			uart_tx_en		,				//enable signal 
	//UART output
	output	reg		uart_tx_done	,				//done signal
	output	reg		uart_txd 						//transmition data
);	

//param define
localparam	integer BPS_CNT		= CLK_FRE / BPS	;	//clock cycles consumed by every bit
localparam	integer	BITS_NUM	=10				;	//bit number

//reg define
reg			tx_state			;					//transmition mark
reg	[7:0]	uart_tx_data_reg	;					//data register
reg [31:0]	clk_cnt				;					//counter of clock sycle consumed by every bit
reg [3:0]	bit_cnt				;					//bit couter

//(1)save data after enable signal arrave
always @(posedge sys_clk or negedge  sys_rst_n)begin
	if(!sys_rst_n)
		uart_tx_data_reg <= 8'd0;				//reset
	else if(uart_tx_en)
		uart_tx_data_reg <= uart_tx_data;		//save data
	else
		uart_tx_data_reg <=uart_tx_data_reg;	//maintain cur state
end

//(2)transmition process 
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		tx_state <=	1'b0;
	else if(uart_tx_en)
		tx_state <=	1'b1;
	else if((bit_cnt == BITS_NUM -1) && (clk_cnt == BPS_CNT -1))
		tx_state <=	1'b0;
	else
		tx_state <= tx_state;
end

//(3)set done signal,same as (2)
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		uart_tx_done <=	1'b0;
	else if(uart_tx_en)
		uart_tx_done <=	1'b1;
	else if((bit_cnt == BITS_NUM -1) && (clk_cnt == BPS_CNT -1))
		uart_tx_done <=	1'b0;
	else
		uart_tx_done <= uart_tx_done;
end

//(4)counter
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		clk_cnt <= 32'd0;
		bit_cnt <= 4'd0;
	end
	else if(tx_state)begin
		if(clk_cnt <BPS_CNT -1)begin
			clk_cnt <= clk_cnt + 1'b1;
			bit_cnt <= bit_cnt;
		end
		else begin
			clk_cnt <= 32'd0;
			bit_cnt <= bit_cnt + 1'b1;
		end
	end
	else begin
		clk_cnt <= 32'd0;
		bit_cnt <= 4'd0;
	end
end

//(5)assign uart output according to bit
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		uart_txd <= 1'b0;
	else if(tx_state)begin
		case(bit_cnt)
			4'd0: uart_txd <= 1'b0;
			4'd1: uart_txd <= uart_tx_data_reg[0];
			4'd2: uart_txd <= uart_tx_data_reg[1];
			4'd3: uart_txd <= uart_tx_data_reg[2];
			4'd4: uart_txd <= uart_tx_data_reg[3];
			4'd5: uart_txd <= uart_tx_data_reg[4];
			4'd6: uart_txd <= uart_tx_data_reg[5];
			4'd7: uart_txd <= uart_tx_data_reg[6];
			4'd8: uart_txd <= uart_tx_data_reg[7];
			4'd9: uart_txd <= 1'b1;
			default: uart_txd <= 1'b1;
		endcase
	end
	else
		uart_txd <= 1'b1;
end

endmodule 
