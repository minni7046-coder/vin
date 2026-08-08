module smart_energy_meter #(
    parameter VOLTAGE = 230,
    parameter POWER_LIMIT = 1000
)(
    input  wire        clk,
    input  wire        reset,

    input  wire [15:0] voltage_in,
    input  wire [15:0] current_in,

    output reg [31:0] power_w,
    output reg [31:0] energy_wh,
    output reg        overload
);

    // Calculate power and accumulate energy
    // For simulation, one clock cycle represents one second.
    always @(posedge clk or posedge reset) begin

        if (reset) begin
            power_w  <= 0;
            energy_wh <= 0;
            overload <= 0;
        end

        else begin

            // Power = Voltage × Current
            power_w <= voltage_in * current_in;

            // Accumulate energy
            // One clock cycle is treated as one second.
            energy_wh <= energy_wh +
                         ((voltage_in * current_in) / 3600);

            // Overload detection
            if ((voltage_in * current_in) > POWER_LIMIT)
                overload <= 1'b1;
            else
                overload <= 1'b0;

        end
    end

endmodule