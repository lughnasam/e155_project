// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module is the top-level module for our E155 final project
//              implementing guitar pedals

module top(input logic reset, adc_sdi, chorus_on, reverb_on,
           input logic mcu_sck, mcu_transfer,
           output logic chip_en, adc_sdo, fpga_sck, mcu_sdo, tfr_ready, start);

    logic int_osc, start_sample, write_en, main_read, inc_adr;
    logic [1:0] value;
    logic [15:0] address, write_data, mem_out;
    logic [11:0] adc_read;

    // HSOSC at 6 MHz
    HSOSC #(.CLKHF_DIV(2'b11)) hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // clk divide to 3 MHz
    counter #(.WIDTH(2)) count(.clk(int_osc), .reset(~reset), .value(value));
    
    // grab fpga clk bit (toggles at 3 MHz per above)
    assign fpga_sck = value[1];

    // every 30 clocks, assert a sample begin signal
    clock_divider clkDiv(.clk(fpga_sck), .reset(~reset), .start_sample(start_sample));

    // SPI handler for ADC
    dac_spi dacSpi(.sck(fpga_sck), .sdi(adc_sdi), .reset(~reset), .sdo(adc_sdo), 
                    .chip_en(chip_en), .data_read(adc_read), .start_read(start_sample),
                    .write_en(write_en));

    // zero extend to 16 bits for memory write
    assign write_data = {4'b0, adc_read};

    // address counter
    address_counter addressCount(.clk(fpga_sck), .inc_adr(inc_adr), .reset(~reset), .address(address));

    // memory bank
    memory_storage dataMem(.clk(fpga_sck), .write(write_en), .address(address), .datain(write_data), 
                            .dataout(mem_out));

    // datapath fsm
    dp_fsm dpFSM(.clk(fpga_sck), .reset(~reset), .start(start_sample), .rev_read(rev_read),
                  .chor_read(chor_read), .main_read(main_read), .tfr_ready(tfr_ready),
				  .inc_adr(inc_adr), .transmit(mcu_transfer));

    // shift register accepting clock from BOTH FPGA and MCU
    shift_reg_mcu_spi mcuSPI(.mcu_sck(mcu_sck), .fpga_sck(fpga_sck), .reset(~reset), .load(main_read), 
                            .transmit(mcu_transfer), .data_load(mem_out), .mcu_sdo(mcu_sdo));

endmodule