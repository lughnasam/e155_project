module shift_reg(input  logic        clk, reset, in,
                 output logic [11:0] data_out);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) dataout <= 12'b0;
        else       dataout = {dataout[10:0], in};
    end
    
endmodule