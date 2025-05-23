# Project information
project:
  title: "LED Pattern Generator"
  author: "Emre Dayangac"
  description: "A programmable LED pattern generator with four selectable modes: binary counter, Knight Rider scanner, pseudo-random LFSR, and alternating patterns."
  language: "Verilog"
  source_files:
    - "project.v"
  top_module: "LED_Pattern_Generator"

# How the project works
how_it_works: |
  This design generates four different LED patterns based on the selected mode:
  
  Mode 00: Binary Counter - Counts up in binary with 8-bit output
  Mode 01: Knight Rider - Shifting pattern that bounces back and forth
  Mode 02: Pseudo-Random - Uses an 8-bit LFSR with taps at bits 7,5,4,3
  Mode 03: Alternating - Toggles between two complementary patterns (0x55/0xAA)
  
  The design uses a synchronous state machine with an internal counter for timing.
  Pattern updates occur at regular intervals determined by the clock frequency.

# How to test the project
how_to_test: |
  1. Connect 8 LEDs with current-limiting resistors (220Ω) to the output pins
  2. Connect two switches or jumpers to the mode selection pins (inputs 0 and 1)
  3. Apply clock and reset signals
  4. Toggle mode switches to select between the four pattern modes
  5. Observe the LED patterns changing according to the selected mode

# Pin definitions
pinout:
  ## Inputs
  ui[0]: "mode[0]"
  ui[1]: "mode[1]"
  ui[2]: "none"
  ui[3]: "none"
  ui[4]: "none"
  ui[5]: "none"
  ui[6]: "none"
  ui[7]: "none"

  ## Outputs
  uo[0]: "led[0]"
  uo[1]: "led[1]"
  uo[2]: "led[2]"
  uo[3]: "led[3]"
  uo[4]: "led[4]"
  uo[5]: "led[5]"
  uo[6]: "led[6]"
  uo[7]: "led[7]"

  ## Bidirectional (not used)
  uio[0]: "none"
  uio[1]: "none"
  uio[2]: "none"
  uio[3]: "none"
  uio[4]: "none"
  uio[5]: "none"
  uio[6]: "none"
  uio[7]: "none"

# Optional clock frequency
clock_hz: 10000

# Additional tags
tags:
  - led
  - pattern
  - educational
  - demo
