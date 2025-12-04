module clock_divider(input logic clk, reset,
                     output logic start_sample);

    logic [6:0] counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) counter <= 0;
        else if (counter >= 7'd29) counter <= 0;
        else counter <= counter + 1;
    end

    assign start_sample = (counter == 0);

endmodule