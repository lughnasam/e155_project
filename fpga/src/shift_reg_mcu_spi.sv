module shift_reg_mcu_spi(input        mcu_sck, fpga_sck, reset, load, transmit,
                         input [15:0] data_load,
                         output       mcu_sdo);

    logic [15:0] register;

    always_ff @(posedge fpga_sck, posedge reset) begin
        if (reset)     register <= 0;
        else if (load) register <= data_load;
    end

    always_ff @(posedge mcu_sck) begin
        if (transmit) {mcu_sdo, register} <= {register, 0};
    end

endmodule