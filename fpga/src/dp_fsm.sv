module dp_fsm(input logic clk, reset, start,
              output logic rev_read, chor_read, main_read, 
              );

    typedef enum logic [2:0] {pause, read_main, chorus, reverb, ready}

endmodule