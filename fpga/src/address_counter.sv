module address_counter(input logic clk, reset, inc_adr,
                       output logic [15:0] address);

    always @(posedge clk) begin
        if (reset)        address <= 0;
        else if (inc_adr) address <= address + 1;
    end

endmodule