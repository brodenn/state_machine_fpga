module timer #(
    parameter int CLK_FREQ_HZ = 50_000_000
)(
    input  logic clk,
    input  logic reset_n,
    input  logic [1:0] speed_select,  // 00 = OFF, 01 = SLOW, 10 = MEDIUM, 11 = FAST
    output logic tick
);

    logic [31:0] counter = 0;
    logic [31:0] threshold;

    // Välj rätt tröskelvärde beroende på tillstånd
    always_comb begin
        case (speed_select)
            2'b01: threshold = CLK_FREQ_HZ / 1;   // 1 Hz
            2'b10: threshold = CLK_FREQ_HZ / 10;  // 10 Hz
            2'b11: threshold = CLK_FREQ_HZ / 100; // 100 Hz
            default: threshold = 32'hFFFFFFFF;    // Off
        endcase
    end

    // Räknar klockcykler tills tröskel nås
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 0;
            tick <= 0;
        end else if (speed_select == 2'b00) begin
            counter <= 0;
            tick <= 0;
        end else if (counter >= threshold - 1) begin
            counter <= 0;
            tick <= 1;
        end else begin
            counter <= counter + 1;
            tick <= 0;
        end
    end

endmodule
