module spi_fsm(input logic sck, start_read, reset,
               output logic sdo, reading, chip_en);

    typedef enum logic {pause, start, sgl, channel, msbf, readNull, read11, read10, read9, read8, read7, read6, read5, read4, read3, read2, read1, read0} statetype;
    statetype state, next_state;

    always_ff @(posedge clk, negedge reset) begin
        if (reset) state <= pause;
        else       state <= next_state;
    end

    always_comb begin
        case (state)
            pause: if (start_read) next_state = start;
                   else  next_state = pause;
            start:       next_state = sgl;
            sgl:         next_state = channel;
            channel:     next_state = msbf;
            msbf:        next_state = readNull;
            readNull:    next_state = read11;
            read11:      next_state = read10;
            read10:      next_state = read9; 
            read9:       next_state = read8;
            read8:       next_state = read7;
            read7:       next_state = read6;
            read6:       next_state = read5;
            read5:       next_state = read4;
            read4:       next_state = read3;
            read3:       next_state = read2;
            read2:       next_state = read1;
            read1:       next_state = read0;
            read0:       next_state = pause;  
            default:     next_state
        endcase
    end

    assign sdo = (state == start) || (state == sgl) || (state == msbf); 
    assign reading = |{read11, read10, read9, read8, read7, read6, read5, read4, read3, read2, read1, read0};
    assign chip_en = (state == pause);
    

endmodule