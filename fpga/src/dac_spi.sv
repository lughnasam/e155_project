// Names: Kanoa Parker and Lughnasa Miller
// Date: 11/15/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module controls SPI communication with an
//              external MCP3202 ADC.

module dac_spi(input  logic sck, 
               input  logic sdi,
               output logic sdo,
               output logic chip_en,
               output logic [11:0] key, plaintext,
               input  logic [127:0] cyphertext);

    logic reading;

    spi_fsm fsm(.sck(sck), .start_read(start_read), .reset(reset), .sdo(sdo), 
                    .reading(reading), .chip_en(chip_en));
    
    shift_reg shift()


endmodule