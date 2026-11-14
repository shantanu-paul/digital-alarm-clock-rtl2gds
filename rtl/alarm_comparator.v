// =============================================================================
// Module: alarm_comparator
// Course: EEE411L - VLSI Design Laboratory
// Project: Design of a Digital Alarm Clock
// Description: Compares current time (hour, min) with programmed alarm time
//              (alarm_hr, alarm_min) and asserts alarm output flag.
// =============================================================================

`timescale 1ns / 1ps

module alarm_comparator (
    input  wire       reset,
    input  wire [4:0] hour,
    input  wire [5:0] min,
    input  wire [4:0] alarm_hr,
    input  wire [5:0] alarm_min,
    output reg        alarm
);

    always @(*) begin
        if (reset) begin
            alarm = 1'b0;
        end else begin
            if ((hour == alarm_hr) && (min == alarm_min)) begin
                alarm = 1'b1;
            end else if (alarm) begin
                if (min != alarm_min) begin
                    alarm = 1'b0;
                end else begin
                    alarm = 1'b1;
                end
            end else begin
                alarm = 1'b0;
            end
        end
    end

endmodule
