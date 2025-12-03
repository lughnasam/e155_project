`timescale 1ns/1ns
`default_nettype none
`define N_TV 13
module address_counter_tb();
	logic clk, reset;
	logic [31:0] vectornum,errors;
    logic [31:0] vectornum,errors;
	logic [15:0] address, expected_address;
	
	// instantiate device under test
	address_counter dut(clk,reset,address);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0, expected_address = 0;
		end
		
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		// apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1;
			$display("%b ", address);
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(address !==expected_address) begin
					$display("Address outputs = %b (%b expected)", address, expected_address);
					errors = errors + 1;
				end;

            if (vectornum=== 1000) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end

            vectornum = vectornum +1;
            expected_address = expected_address + 1;
            if (expected_address == 16'd10000)
                expected_address = 0;
		end
		
endmodule 