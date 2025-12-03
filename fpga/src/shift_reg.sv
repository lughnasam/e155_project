module shift_reg(input  logic        clk, reset, in, reading,
                 output logic [11:0] dataout);

    always_ff @(posedge clk, posedge reset) begin
        if (reset)        dataout <= 12'b0;
        else if (reading) dataout <= {dataout[10:0], in};
        else              dataout <= dataout;
    end
    
endmodule