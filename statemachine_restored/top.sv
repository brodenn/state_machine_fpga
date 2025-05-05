module top (
    input  logic CLOCK_50,     // 50 MHz clock
    input  logic [2:0] KEY,    // KEY[0] = up, KEY[1] = down, KEY[2] = reset
    output logic [6:0] HEX0,   // units
    output logic [6:0] HEX1    // tens
);

    // Interna signaler
    logic [1:0] speed_select;
    logic tick;
    logic btn_up, btn_down;
    logic [3:0] units, tens;

    // Flankdetektering
    edge_detector up_detector (
        .clk(CLOCK_50),
        .reset_n(KEY[2]),
        .signal_in(KEY[0]),
        .rising_edge(btn_up)
    );

    edge_detector down_detector (
        .clk(CLOCK_50),
        .reset_n(KEY[2]),
        .signal_in(KEY[1]),
        .rising_edge(btn_down)
    );

    // Tillståndsmaskin
    statemachine sm (
        .clk(CLOCK_50),
        .reset_n(KEY[2]),
        .btn_up(btn_up),
        .btn_down(btn_down),
        .speed_select(speed_select)
    );

    // Timer
    timer timer_inst (
        .clk(CLOCK_50),
        .reset_n(KEY[2]),
        .speed_select(speed_select),
        .tick(tick)
    );

    // Räknare
    counter count (
        .clk(CLOCK_50),
        .reset_n(KEY[2]),
        .tick(tick),
        .tens(tens),
        .units(units)
    );

    // HEX-display
    hex_decoder hex0 (
        .bcd(units),
        .seg(HEX0)
    );

    hex_decoder hex1 (
        .bcd(tens),
        .seg(HEX1)
    );

endmodule
