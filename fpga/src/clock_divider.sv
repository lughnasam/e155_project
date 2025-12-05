// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module sends a pulse to start a sample cycle in our datapath
//              and ADC SPI FSM.

module clock_divider(input logic clk, reset,
                     output logic start_sample);

    logic [6:0] counter;

    // every 30 clock cycles, send ready signal
    always_ff @(posedge clk, posedge reset) begin
        if (reset) counter <= 0;
        else if (counter >= 7'd29) counter <= 0;
        else counter <= counter + 1;
    end

    assign start_sample = (counter == 0);

endmodule