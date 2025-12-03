module spi_fsm(input logic sck, start_read, reset,
               output logic sdo, reading, chip_en, write_en);

    typedef enum logic [2:0] {pause, start, sgl, channel, msbf, readNull, readBits, write} statetype;
    statetype state, next_state;
    logic [3:0] count;

    always_ff @(posedge sck, posedge reset) begin
        // state register
        if (reset) state <= pause;
        else       state <= next_state;

        // read state counter
        if (reset) count <= 0;
        else if (state == readBits) count <= count + 1;
        else count <= 0;

    end

    always_comb begin
        case (state)
            pause: if (start_read) next_state = start;
                   else  next_state = pause;
            start:       next_state = sgl;
            sgl:         next_state = channel;
            channel:     next_state = msbf;
            msbf:        next_state = readNull;
            readNull:    next_state = readBits;
            readBits: if (count < 11) next_state = readBits; 
                    else next_state = write;
            write:       next_state = pause;
            default:     next_state = pause;
        endcase
    end

    assign sdo = (state == start) || (state == sgl) || (state == msbf); 
    assign reading = (state == readBits);
    assign chip_en = (state == pause) | (state == write);
    assign write_en = (state == write);


endmodule