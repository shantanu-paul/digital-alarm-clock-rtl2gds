// =============================================================================
// Module: top_module
// Course: EEE411L - VLSI Design Laboratory
// Project: Design of a Digital Alarm Clock
// Description: Top-level integration of clock counter module and alarm comparator.
// =============================================================================

`timescale 1ns / 1ps

module top_module (
    input  wire       clk,
    input  wire       clk_reset,
    input  wire       alarm_reset,
    input  wire [5:0] reset_min,
    input  wire [4:0] reset_hour,
    input  wire [4:0] alarm_hr,
    input  wire [5:0] alarm_min,
    output wire [5:0] sec,
    output wire [5:0] min,
    output wire [4:0] hour,
    output wire       alarm
);

    // Clock counter instance
    clock_module clock_1 (
        .clk        (clk),
        .reset      (clk_reset),
        .reset_min  (reset_min),
        .reset_hour (reset_hour),
        .sec        (sec),
        .min        (min),
        .hour       (hour)
    );

    // Alarm comparator instance
    alarm_comparator alarm_comp (
        .reset     (alarm_reset),
        .hour      (hour),
        .min       (min),
        .alarm_hr  (alarm_hr),
        .alarm_min (alarm_min),
        .alarm     (alarm)
    );

endmodule
