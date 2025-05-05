module statemachine (
    input  logic clk,
    input  logic reset_n,
    input  logic btn_up,    // Från edge_detector på KEY0
    input  logic btn_down,  // Från edge_detector på KEY1
    output logic [1:0] speed_select  // 00=OFF, 01=SLOW, 10=MED, 11=FAST
);

    typedef enum logic [1:0] {
        OFF    = 2'b00,
        SLOW   = 2'b01,
        MEDIUM = 2'b10,
        FAST   = 2'b11
    } state_t;

    state_t state;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= OFF;
        else begin
            case (state)
                OFF:    if (btn_up)   state <= SLOW;
                SLOW:   if (btn_up)   state <= MEDIUM;
                        else if (btn_down) state <= OFF;
                MEDIUM: if (btn_up)   state <= FAST;
                        else if (btn_down) state <= SLOW;
                FAST:   if (btn_down) state <= MEDIUM;
            endcase
        end
    end

    assign speed_select = state;

endmodule
