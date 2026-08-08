`timescale 1ns/1ps

module smart_energy_meter_tb;

    reg clk;
    reg reset;

    reg [15:0] voltage_in;
    reg [15:0] current_in;

    wire [31:0] power_w;
    wire [31:0] energy_wh;
    wire overload;

    // Instantiate DUT
    smart_energy_meter #(
        .POWER_LIMIT(1000)
    ) uut (
        .clk(clk),
        .reset(reset),
        .voltage_in(voltage_in),
        .current_in(current_in),
        .power_w(power_w),
        .energy_wh(energy_wh),
        .overload(overload)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin

        $monitor(
            "Time=%0t | Voltage=%0d V | Current=%0d A | Power=%0d W | Energy=%0d Wh | Overload=%b",
            $time,
            voltage_in,
            current_in,
            power_w,
            energy_wh,
            overload
        );

        // Initial values
        clk        = 0;
        reset      = 1;
        voltage_in = 0;
        current_in = 0;

        // Reset
        #10;
        reset = 0;

        // Load 1: 230V × 2A = 460W
        voltage_in = 230;
        current_in = 2;

        #20;

        // Load 2: 230V × 3A = 690W
        voltage_in = 230;
        current_in = 3;

        #20;

        // Load 3: 230V × 5A = 1150W
        // Exceeds 1000W limit
        voltage_in = 230;
        current_in = 5;

        #20;

        // Return to normal load
        voltage_in = 230;
        current_in = 1;

        #20;

        $finish;

    end

endmodule