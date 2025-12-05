// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module updates the "current" memory location after the
//              FPGA finishes a data read from the ADC.

module address_counter(input logic clk, reset, inc_adr
                       output logic [15:0] address);

    always_ff @(posedge clk, posedge reset) begin
        if (reset)        address <= 0;
        else if (inc_adr) address <= address + 1;
    end

endmodule