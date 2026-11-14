// =============================================================================
// Module: clock_module
// Course: EEE411L - VLSI Design Laboratory
// Project: Design of a Digital Alarm Clock
// Description: Real-time digital clock counting seconds (0-59),
//              minutes (0-59), and hours (0-23) with synchronous preset & reset.
// =============================================================================

`timescale 1ns / 1ps

module clock_module (
    input  wire        clk,
    input  wire        reset,
    input  wire [5:0]  reset_min,
    input  wire [4:0]  reset_hour,
    output reg  [5:0]  sec,
    output reg  [5:0]  min,
    output reg  [4:0]  hour
);

    always @(posedge clk) begin
        if (reset) begin
            sec  <= 6'd0;
            min  <= reset_min;
            hour <= reset_hour;
        end else begin
            if (sec == 6'd59) begin
                sec <= 6'd0;
                if (min == 6'd59) begin
                    min <= 6'd0;
                    if (hour == 5'd23)
                        hour <= 5'd0;
                    else
                        hour <= hour + 1'b1;
                end else begin
                    min <= min + 1'b1;
                end
            end else begin
                sec <= sec + 1'b1;
            end
        end
    end

endmodule
