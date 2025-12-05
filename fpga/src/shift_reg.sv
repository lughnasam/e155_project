// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: Single clocked shift register for DAC communications.

module shift_reg(input  logic        clk, reset, in, reading,
                 output logic [11:0] dataout);

    always_ff @(posedge clk, posedge reset) begin
        if (reset)        dataout <= 12'b0;
        else if (reading) dataout <= {dataout[10:0], in};
        else              dataout <= dataout;
    end
    
endmodule