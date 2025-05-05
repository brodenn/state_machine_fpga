module edge_detector (
    input  logic clk,
    input  logic reset_n,
    input  logic signal_in,
    output logic rising_edge
);

    logic prev;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            prev <= 1'b0;
        else
            prev <= signal_in;
    end

    assign rising_edge = ~prev & signal_in;

endmodule
