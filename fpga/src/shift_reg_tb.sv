// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: Basic shift register testbench


`timescale 1ns/1ns
`default_nettype none
`define N_TV 13
module shift_reg_tb();
	logic [31:0] vectornum,errors;
	logic [15:0] testvectors[10000:0];
	logic clk, reset, in, reading;
    logic [11:0] dataout,expected_dataout;
	
	// instantiate device under test
	shift_reg dut(clk, reset, in, reading,dataout);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("C:/Users/kanparker/Downloads/e155_project/fpga/src/spi_fsm_vector.tv", testvectors, 0, `N_TV - 1);
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0;
		end
		
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		// apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1; {reading,in,expected_dataout} = testvectors[vectornum];
			///$display("%b %b %b %b", row, columns, cont,stop_expected);
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(dataout !==expected_dataout) begin
					$display("Error: inputs = %b %b", reading, in);
					$display(" data outputs = %b (%b expected)", dataout, expected_dataout);
					errors = errors + 1;
				end;
			
				
			assign vectornum = vectornum +1;
			
			if (testvectors[vectornum] === 16'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
				
		end
		
		
		
		
		

endmodule 