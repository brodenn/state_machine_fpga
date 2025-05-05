# Finite State Machine Counter 🔁

A SystemVerilog implementation of a configurable FSM-driven counter for the DE0-CV FPGA board.

![State Machine](./images/state_machine.jpg)  
*Figure: State machine diagram illustrating the FSM-driven counter.*

## Features
- Counts from 0 to 99 and wraps back to 0 after 100.
- Displayed as hexadecimal on `HEX[1:0]` 7-segment displays.
- Controlled by a 4-state FSM:
  - `COUNTER_OFF`
  - `COUNTER_STATE_SLOW` (1 Hz)
  - `COUNTER_STATE_MEDIUM` (10 Hz)
  - `COUNTER_STATE_FAST` (100 Hz)
- Buttons:
  - `KEY0` and `KEY1` used to go to the next/previous state.
  - `KEY2` resets both FSM and counter.
- Metastability protection with edge detectors.
- Configurable counter max value and clock division using parameters.

## Modules
- **`top.sv`** – Main module with FSM, counter, clock divider, and display.
- **`fsm.sv`** – Finite state machine logic.
- **`counter.sv`** – BCD counter to 99 with max-value parameter.
- **`clock_divider.sv`** – Adjustable clock divider based on FSM state.
- **`edge_detector.sv`** – Clean button press handling.
- **`hex_decoder.sv`** – Converts BCD to 7-segment display.

## Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/fsm-counter.git
   ```
2. Open the project in Quartus.
3. Assign the following pins in Pin Planner:
   - `KEY[2:0]` → Connect to physical keys.
   - `HEX[1:0]` → Connect to HEX0 and HEX1.
4. Compile and flash to the DE0-CV board.
5. Press `KEY0` and `KEY1` to switch states, `KEY2` to reset.

## Directory Structure
- **`top.sv`**: Integration of all modules.
- **`rtl/`**: All logic modules.
- **`sim/`**: Simulation testbenches.
- **`db/`, `output_files/`**: Quartus build outputs.

## Requirements
- Intel Quartus Prime.
- Terasic DE0-CV board (5CEBA4F23C7).
- Basic SystemVerilog knowledge.