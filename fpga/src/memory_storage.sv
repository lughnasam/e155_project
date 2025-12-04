module memory_storage(input  logic        clk, write,
                   input  logic [15:0] address,
                   input  logic [15:0] datain,
                   output logic [15:0] dataout);
    
    logic [15:0] data1, data2, data3, data4;
    logic        wren1, wren2, wren3, wren4;

    // write enable signals
    assign wren1 = ~address[15] & ~address[14] & write;
    assign wren2 = ~address[15] & address[14] & write;
    assign wren3 = address[15] & ~address[14] & write;
    assign wren4 = address[15] & address[14] & write;

    // 4 16Kx16 RAM blocks for 64K of memory (640 ms of data storage)
    SP256K ramfn_inst1(
        .DI(datain),
        .AD(address[13:0]),
        .MASKWE(4'b0111),
        .WE(wren1),
        .CS(1'b1),
        .CK(clk),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1),
        .DO(data1)
    );

    SP256K ramfn_inst2(
        .DI(datain),
        .AD(address[13:0]),
        .MASKWE(4'b0111),
        .WE(wren2),
        .CS(1'b1),
        .CK(clk),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1),
        .DO(data2)
    );

    SP256K ramfn_inst3(
        .DI(datain),
        .AD(address[13:0]),
        .MASKWE(4'b0111),
        .WE(wren3),
        .CS(1'b1),
        .CK(clk),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1),
        .DO(data3)
    );

    SP256K ramfn_inst4(
        .DI(datain),
        .AD(address[13:0]),
        .MASKWE(4'b0111),
        .WE(wren4),
        .CS(1'b1),
        .CK(clk),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1),
        .DO(data4)
    );
	
    // mux for data output
    assign dataout = address[15] ? (address[14] ? data4 : data3):
                                   (address[14] ? data2 : data1);

endmodule