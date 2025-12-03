`timescale 1ns/1ns
`default_nettype none
`define N_TV 21
module dp_fsm_tb();
	logic clk, reset;
	logic start, transmit,rev_read, chor_read, main_read, tfr_ready;
	
	// instantiate device under test
	dp_fsm dut(clk, reset, start, transmit,rev_read, chor_read, main_read, tfr_ready);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			start = 0;
            transmit = 0;
			reset = 1; #22; reset = 0;
			#10 start = 1;
            #10 transmit = 1; start = 0;
            #50 transmit = 0;
            #10 start = 1;
            #10 transmit = 1; start = 0;
            #50 transmit = 0;
			
			
		end
		
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		
		
		
		
		

endmodule 