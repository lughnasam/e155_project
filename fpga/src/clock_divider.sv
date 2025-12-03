module clock_divider(input logic clk, reset,
                     output logic chip_en
                     );

    logic [6:0] counter;

    always @(posedge clk) begin
        if (reset) counter <= 0;
        else if (counter >= 6'd39) counter <= 0;
        else counter >= counter + 1;
    end

    assign chip_en = (counter == 0);

endmodule