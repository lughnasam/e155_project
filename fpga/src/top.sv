module top(input logic reset, adc_sdi, chorus_on, reverb_on,
           output logic chip_en, adc_sdo, fpga_sck);

    logic int_osc, start_sample;
    logic [2:0] value;
    logic [15:0] address, write_data;
    logic 

    // HSOSC at 6 MHz
    HSOSC #(.CLKHF_DIV(2'b11)) hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // clk divide to 3 MHz
    counter #(.WIDTH(2)) count(.clk(int_osc), .reset(reset), .value(value));
    
    // grab fpga clk bit (toggles at 3 MHz per above)
    assign fpga_sck = value[1];

    // every 30 clocks, assert a sample begin signal
    clock_divider clkDiv(.clk(fpga_sck), .reset(reset), .start_sample(start_sample));

    // SPI handler for ADC
    dac_spi dacSpi(.sck(fpga_sck), .sdi(adc_sdi), .reset(reset), .sdo(adc_sdo), 
                    .chip_en(chip_en), .data_read(adc_read));

    // zero extend to 16 bits for memory write
    assign write_data = {4'b0, adc_read};

    // address counter
    address_counter addressCount(.clk(clk), .inc_adr(inc_adr), .reset(reset), .address(address));

    // memory bank
    memory_storage dataMem()

endmodule