// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: Testbench for FPGA/ADC SPI communications FSM

`timescale 1ns/1ns
`default_nettype none
`define N_TV 21
module spi_fsm_tb();
	logic clk, reset;
	logic start_read;
    logic sdo, reading, chip_en;
	
	// instantiate device under test
	spi_fsm dut(clk, start_read, reset, sdo, reading, chip_en);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			start_read = 0;
			reset = 1; #22; reset = 0;
			#10 start_read = 1;
            #10 start_read = 0;
			
			
		end
		
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		
		
		
		
		

endmodule 