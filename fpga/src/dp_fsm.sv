// Names: Kanoa Parker and Lughnasa Miller
// Date: 12/3/2025
// Email: kanparker@hmc.edu, lumiller@hmc.edu
// Description: This module implements an FSM that outputs control signals for our datapath

module dp_fsm(input logic clk, reset, start, transmit,
              output logic rev_read, chor_read, main_read, tfr_ready, inc_adr);

    typedef enum logic [2:0] {pause, read_main, chorus, reverb, ready, mcu_wait, mcu_spi} statetype;

    statetype state, next_state;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) state <= pause;
        else       state <= next_state;
    end

    always_comb begin
        case (state)
            pause:   if (start)     next_state = read_main;
                     else           next_state = pause;
            read_main:              next_state = ready;
            ready:                  next_state = mcu_wait;
            mcu_wait: if (~transmit) next_state = mcu_spi;
                       else         next_state = mcu_wait;
            mcu_spi: if (~transmit)  next_state = mcu_spi;
                     else           next_state = pause;
            default:                next_state = pause;
        endcase
    end

    assign rev_read = (state == reverb);
    assign chor_read = (state == chorus);
    assign main_read = (state == read_main);
    assign tfr_ready = (state == ready) | (state == mcu_wait);
    assign inc_adr = (state == ready);


endmodule