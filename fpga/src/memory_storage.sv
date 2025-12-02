module memory_bank(input logic         clk, write,
                   input logic [15:0]  address,
                   input logic [15:0]  datain,
                   output logic [15:0] dataout);
    
    logic [15:0] data1, data2, data3, data4;
    logic        wren1, wren2, wren3, wren4;

    // write enable signals
    assign wren1 = ~address[15] & ~address[14] & write;
    assign wren2 = ~address[15] & address[14] & write;
    assign wren3 = address[15] & ~address[14] & write;
    assign wren4 = address[15] & address[14] & write;

    // 4 16Kx16 RAM blocks for 64K of memory (640 ms of data storage)
    SB_SPRAM256KA ramfn_inst1(
        .DATAIN(datain),
        .ADDRESS(address[13:0]),
        .MASKWREN(4'b0111),
        .WREN(wren1),
        .CHIPSELECT(1'b1),
        .CLOCK(clk),
        .STANDBY(1'b0),
        .SLEEP(1'b0),
        .POWEROFF(1'b0),
        .DATAOUT(data1)
    )

    SB_SPRAM256KA ramfn_inst2(
        .DATAIN(datain),
        .ADDRESS(address[13:0]),
        .MASKWREN(4'b0111),
        .WREN(wren2),
        .CHIPSELECT(1'b1),
        .CLOCK(clk),
        .STANDBY(1'b0),
        .SLEEP(1'b0),
        .POWEROFF(1'b0),
        .DATAOUT(data2)
    )

    SB_SPRAM256KA ramfn_inst3(
        .DATAIN(datain),
        .ADDRESS(address[13:0]),
        .MASKWREN(4'b0111),
        .WREN(wren3),
        .CHIPSELECT(1'b1),
        .CLOCK(clk),
        .STANDBY(1'b0),
        .SLEEP(1'b0),
        .POWEROFF(1'b0),
        .DATAOUT(data3)
    )

    SB_SPRAM256KA ramfn_inst4(
        .DATAIN(datain),
        .ADDRESS(address[13:0]),
        .MASKWREN(4'b0111),
        .WREN(wren4),
        .CHIPSELECT(1'b1),
        .CLOCK(clk),
        .STANDBY(1'b0),
        .SLEEP(1'b0),
        .POWEROFF(1'b0),
        .DATAOUT(data4)
    )

    // mux for data output
    assign dataout = address[15] ? (address[14] ? data4 : data3):
                                   (address[14] ? data2 : data1);

endmodule