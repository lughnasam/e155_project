// Names: Kanoa Parker and Lughnasa Miller
// Date: 11/15/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module controls SPI communication with an
//              external MCP3202 ADC.

module dac_spi(input  logic sck, sdi, reset, 
               output logic sdo, chip_en,
               output logic [11:0] data_read);

    logic reading;

    spi_fsm fsm(.sck(sck), .start_read(start_read), .reset(reset), .sdo(sdo), 
                    .reading(reading), .chip_en(chip_en));
    
    shift_reg shift(.clk(sck), .reset(reset), .data_out(data_read), .reading(reading));


endmodule