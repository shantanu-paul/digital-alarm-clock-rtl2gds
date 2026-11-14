// =============================================================================
// Testbench: alarm_comparator_tb
// Course: EEE411L - VLSI Design Laboratory
// Description: Testbench verifying alarm comparator module behavior.
// =============================================================================

`timescale 1ns / 1ps

module alarm_comparator_tb;

    reg        reset;
    reg  [4:0] hour, alarm_hr;
    reg  [5:0] min, alarm_min;
    wire       alarm;

    // Instantiate Design Under Test (DUT)
    alarm_comparator dut (
        .reset     (reset),
        .hour      (hour),
        .min       (min),
        .alarm_hr  (alarm_hr),
        .alarm_min (alarm_min),
        .alarm     (alarm)
    );

    initial begin
        // Waveform dumping for standard VCD / GTKWave
        $dumpfile("alarm_comparator_tb.vcd");
        $dumpvars(0, alarm_comparator_tb);

        `ifdef CADENCE
            $shm_open("shm.db", 1);
            $shm_probe("AS");
        `endif

        reset = 1'b0;
        hour  = 5'd1;
        min   = 6'd10;
        #10;

        // Set matching alarm time
        alarm_hr  = 5'd1;
        alarm_min = 6'd10;
        #100;

        // Change minute (alarm should clear)
        min = 6'd11;
        #100;

        // Update alarm time to match new minute
        alarm_hr  = 5'd1;
        alarm_min = 6'd11;

        // Test reset override
        reset = 1'b1;
        #100;
        reset = 1'b0;
        #100;

        `ifdef CADENCE
            $shm_close();
        `endif

        $display("[INFO] Alarm comparator simulation completed successfully.");
        $finish;
    end

endmodule
