// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module verifies that the memory IP from Lattice is appropriately
//              implemented with address extension.

module testbench;

logic clk, write;

logic [15:0] datain, address, dataout;

memory_storage mem(.clk(clk), .write(write), .address(address), .datain(datain), .dataout(dataout));

always begin
    clk = 1;
    #5;
    clk = 0;
    #5;
end

initial begin
    #10;
    datain = 16'h0001;
    address = 16'h0000;
    write = 1;
    #10;
    datain = 16'h0002;
    address = 16'h4000;
    #10;
    datain = 16'h0003;
    address = 16'h8000;
    #10;
    datain = 16'h0004;
    address = 16'hA000;
    #10;
    address = 16'h0000;
    write = 0;
    assert (dataout == 16'h0001) 
    else $display("error on address %h, value is %d, should be 1", address, dataout);
    #10;
    address = 16'h4000;
    write = 0;
    assert (dataout == 16'h0002) 
    else $display("error on address %h, value is %d, should be 2", address, dataout);
    #10;
    address = 16'h8000;
    write = 0;
    assert (dataout == 16'h0003) 
    else $display("error on address %h, value is %d, should be 1", address, dataout);
    #10;
    address = 16'hA000;
    write = 0;
    assert (dataout == 16'h0004) 
    else $display("error on address %h, value is %d, should be 1", address, dataout);


end



endmodule