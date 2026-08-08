# Smart Energy Meter Using Verilog

## Overview

This project implements a **Smart Energy Meter using Verilog HDL**.

The design measures electrical voltage and current, calculates the instantaneous power consumption, accumulates energy usage, and detects overload conditions.

It is designed as an RTL/FPGA educational project and can be extended with a display, sensors, alarms, or communication interfaces.

## Features

* Voltage measurement input
* Current measurement input
* Power calculation
* Energy accumulation
* Overload detection
* Parameterized power limit
* Active-high asynchronous reset
* Verilog testbench included
* Suitable for FPGA implementation

## Block Diagram

```text
       Voltage Input
             |
             v
      +---------------+
      |               |
      | Smart Energy  |-----> Power
      |    Meter      |
      |               |-----> Energy
      |               |
      |               |-----> Overload
      +---------------+
             ^
             |
       Current Input
```

## Working Principle

The Smart Energy Meter performs three main operations.

### 1. Power Calculation

Electrical power is calculated using:

```text
P = V × I
```

where:

```text
P = Power in Watts
V = Voltage in Volts
I = Current in Amperes
```

For example:

```text
V = 230 V
I = 2 A

P = 230 × 2
P = 460 W
```

### 2. Energy Measurement

Energy is calculated from power and time:

```text
E = P × t
```

For watt-hours:

```text
Energy (Wh) = Power (W) × Time (hours)
```

The RTL design uses a clock-based accumulation model for simulation.

### 3. Overload Detection

The design compares the calculated power with a predefined power limit.

Default limit:

```text
POWER_LIMIT = 1000 W
```

If:

```text
Power > 1000 W
```

then:

```text
overload = 1
```

Otherwise:

```text
overload = 0
```

## Example

For:

```text
Voltage = 230 V
Current = 5 A
```

Power is:

```text
P = 230 × 5
P = 1150 W
```

Since:

```text
1150 W > 1000 W
```

the overload output becomes:

```text
overload = 1
```

## Project Structure

```text
smart-energy-meter/
│
├── smart_energy_meter.v
├── smart_energy_meter_tb.v
└── README.md
```

## Module Interface

| Signal       | Direction | Width | Description         |
| ------------ | --------- | ----: | ------------------- |
| `clk`        | Input     |     1 | System clock        |
| `reset`      | Input     |     1 | Active-high reset   |
| `voltage_in` | Input     |    16 | Voltage input       |
| `current_in` | Input     |    16 | Current input       |
| `power_w`    | Output    |    32 | Calculated power    |
| `energy_wh`  | Output    |    32 | Accumulated energy  |
| `overload`   | Output    |     1 | Overload indication |

## Default Parameters

```verilog
parameter VOLTAGE = 230
parameter POWER_LIMIT = 1000
```

The default overload threshold is:

```text
1000 W
```

## Test Cases

### Test Case 1

```text
Voltage = 230 V
Current = 2 A
```

Expected:

```text
Power = 460 W
Overload = 0
```

### Test Case 2

```text
Voltage = 230 V
Current = 3 A
```

Expected:

```text
Power = 690 W
Overload = 0
```

### Test Case 3

```text
Voltage = 230 V
Current = 5 A
```

Expected:

```text
Power = 1150 W
Overload = 1
```

### Test Case 4

```text
Voltage = 230 V
Current = 1 A
```

Expected:

```text
Power = 230 W
Overload = 0
```

## Expected Output

```text
Voltage   Current    Power       Overload
------------------------------------------
230 V       2 A       460 W          0
230 V       3 A       690 W          0
230 V       5 A      1150 W          1
230 V       1 A       230 W          0
```

The overload condition is correctly activated when the power exceeds 1000 W.

## Simulation

### Using Icarus Verilog

Compile:

```bash
iverilog -o energy_meter_sim smart_energy_meter.v smart_energy_meter_tb.v
```

Run:

```bash
vvp energy_meter_sim
```

## Applications

A Smart Energy Meter architecture can be used in:

* Smart homes
* Industrial energy monitoring
* Power monitoring systems
* FPGA-based energy meters
* IoT energy monitoring
* Load management systems
* Overload protection systems
* Smart grid applications

## Future Improvements

The project can be extended with:

* Voltage and current sensor interfaces
* RMS voltage measurement
* RMS current measurement
* Power factor calculation
* Real-time kWh measurement
* Seven-segment display
* LCD/OLED display
* UART communication
* SPI/I2C sensor interface
* GSM/IoT connectivity
* Automatic load control
* Monthly energy calculation
* Electricity bill estimation
* Peak-load monitoring

## Hardware Implementation

For an FPGA implementation, actual voltage and current measurements should be obtained through suitable isolated/safe sensing and ADC circuitry.

A possible architecture is:

```text
Voltage Sensor ──> ADC ──┐
                         │
                         v
                    +---------+
Current Sensor ──> ADC ──> FPGA
                    +---------+
                         |
                         +----> Power Calculation
                         |
                         +----> Energy Calculation
                         |
                         +----> Overload Detection
                         |
                         +----> Display / UART / IoT
```

## Tools

The Verilog design can be simulated using:

* Icarus Verilog
* Verilator
* ModelSim
* QuestaSim
* Xilinx Vivado
* Intel Quartus
* EDA Playground

## Learning Outcomes

This project demonstrates:

* Verilog RTL design
* Sequential logic
* Arithmetic operations in hardware
* Counters and accumulators
* Parameterized modules
* Status/flag generation
* Testbench development
* FPGA-oriented digital design

## License

This project is intended for educational and academic purposes.
