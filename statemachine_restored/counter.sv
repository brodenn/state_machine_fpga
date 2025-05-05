module counter (
    input  logic clk,
    input  logic reset_n,
    input  logic tick,                  // Från timer
    output logic [3:0] tens, units      // Visas på HEX1:HEX0
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            tens  <= 0;
            units <= 0;
        end else if (tick) begin
            if (units == 9) begin
                units <= 0;
                if (tens == 9)
                    tens <= 0;
                else
                    tens <= tens + 1;
            end else begin
                units <= units + 1;
            end
        end
    end

endmodule
