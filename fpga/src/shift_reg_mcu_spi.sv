
module shift_reg_mcu_spi(input        mcu_sck, fpga_sck, reset, load, transmit,
                         input [15:0] data_load,
                         output       mcu_sdo);

    logic [15:0] register;
	logic sdo_reg, clk;
    
    // MCU clock when transmitting, FPGA clock otherwise
	assign clk = transmit ? mcu_sck : fpga_sck;
	
    always_ff @(posedge clk, posedge reset) begin
        if (reset)     register <= 0;
        else if (load) register <= data_load;
		else if (transmit) {sdo_reg, register} <= {register, 1'b0};
    end

	assign mcu_sdo = sdo_reg;

endmodule