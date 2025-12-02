module address_counter(input clk, reset,
                       output [15:0] address);

    always @(posedge clk) begin
        if (reset) address <= 0;
        else address <= address + 1;
    end

endmodule