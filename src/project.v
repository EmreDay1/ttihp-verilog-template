/*
 * Copyright (c) 2025 Emre Dayangac
 * SPDX-License-Identifier: Apache-2.0
 */

module tt_um_LED_Pattern_Generator (
    input  wire [7:0] inputs,      // General inputs
    output wire [7:0] led_outputs, // LED outputs
    input  wire [7:0] unused_in,   // Unused inputs
    output wire [7:0] unused_out,  // Unused outputs
    output wire [7:0] io_enable,   // IO direction control
    input  wire       enable,      // System enable
    input  wire       clk,         // System clock (REQUIRED NAME)
    input  wire       reset_n      // Active-low reset
);

    // Input assignments
    wire [1:0] pattern_mode = inputs[1:0];  // Use first 2 pins for mode selection
    
    // Configure unused pins
    assign io_enable = 8'b00000000;   // Set as inputs
    assign unused_out = 8'b00000000;  // Default values
    
    // Internal registers
    reg [7:0] timing_counter;      // Timing counter for pattern speeds
    reg [7:0] led_pattern;         // Current LED pattern state
    
    // Connect LED pattern to output pins
    assign led_outputs = led_pattern;
    
    // Pattern generation state machine
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Reset state
            timing_counter <= 8'h0;
            led_pattern <= 8'h00;
        end else if (enable) begin
            // Increment counter
            timing_counter <= timing_counter + 1;
            
            // Update pattern based on selected mode
            case (pattern_mode)
                2'b00: begin
                    // Binary Counter Pattern - counts up in binary
                    if (timing_counter[3:0] == 4'hF) begin
                        led_pattern <= led_pattern + 1;
                    end
                end
                
                2'b01: begin
                    // Knight Rider Scanning Pattern - light moves back and forth
                    if (timing_counter[3:0] == 4'hF) begin
                        if (led_pattern == 8'h00 || led_pattern == 8'h80) begin
                            // Initialize or reset pattern
                            led_pattern <= 8'h01;
                        end else if (led_pattern < 8'h80) begin
                            // Shift left until we reach the leftmost LED
                            led_pattern <= led_pattern << 1;
                        end else begin
                            // Shift right until we reach the rightmost LED
                            led_pattern <= led_pattern >> 1;
                        end
                    end
                end
                
                2'b10: begin
                    // Pseudo-Random Pattern using LFSR
                    if (timing_counter[3:0] == 4'hF) begin
                        // 8-bit Fibonacci Linear Feedback Shift Register
                        led_pattern <= {led_pattern[6:0], 
                                      led_pattern[7] ^ led_pattern[5] ^ 
                                      led_pattern[4] ^ led_pattern[3]};
                        
                        // Prevent LFSR stuck state
                        if (led_pattern == 8'h00) begin
                            led_pattern <= 8'h01;
                        end
                    end
                end
                
                2'b11: begin
                    // Alternating Pattern - switches between two patterns
                    if (timing_counter[3:0] == 4'hF) begin
                        if (led_pattern == 8'h55) begin
                            led_pattern <= 8'hAA;  // 10101010
                        end else begin
                            led_pattern <= 8'h55;  // 01010101
                        end
                    end
                end
            endcase
        end
    end
endmodule
