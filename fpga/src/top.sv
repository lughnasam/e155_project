module top(input logic reset, dac_sdi, chorus_on, reverb_on,
           output logic chip_en, dac_sdo, dac_sck);

    HSOSC #(.CLKHF_DIV(2'b00)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

endmodule