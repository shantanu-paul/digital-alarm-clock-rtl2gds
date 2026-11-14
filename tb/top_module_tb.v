// =============================================================================
// Testbench: top_module_tb
// Course: EEE411L - VLSI Design Laboratory
// Description: Full system testbench verifying clock counting, alarm match,
//              auto-clearing after 1 minute, and asynchronous/synchronous resets.
// =============================================================================

`timescale 1ns / 1ps

module top_module_tb;

    reg        clk;
    reg        clk_reset;
    reg        alarm_reset;
    reg  [5:0] reset_min;
    reg  [4:0] reset_hour;
    reg  [4:0] alarm_hr;
    reg  [5:0] alarm_min;
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hour;
    wire       alarm;

    // Instantiate Design Under Test (DUT)
    top_module dut (
        .clk         (clk),
        .clk_reset   (clk_reset),
        .alarm_reset (alarm_reset),
        .reset_min   (reset_min),
        .reset_hour  (reset_hour),
        .alarm_hr    (alarm_hr),
        .alarm_min   (alarm_min),
        .sec         (sec),
        .min         (min),
        .hour        (hour),
        .alarm       (alarm)
    );

    // Clock generator: 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Waveform dumping for standard VCD / GTKWave
        $dumpfile("top_module_tb.vcd");
        $dumpvars(0, top_module_tb);

        `ifdef CADENCE
            $shm_open("shm.db", 1);
            $shm_probe("AS");
        `endif

        // Step 1: Clock initialization (Set time to 01:00:00)
        clk = 0;
        reset_min = 6'd0;
        reset_hour = 5'd1;
        clk_reset = 1'b1;
        alarm_reset = 1'b0;
        #10;
        clk_reset = 1'b0;

        // Step 2: Set alarm to 01:30 and observe normal counting
        alarm_hr = 5'd1;
        alarm_min = 6'd30;
        #19000;

        // Step 3: Reconfigure time & alarm (Reset to 00:00:00, Alarm at 00:03)
        reset_min = 6'd0;
        reset_hour = 5'd0;
        clk_reset = 1'b1;
        alarm_reset = 1'b1;
        alarm_hr = 5'd0;
        alarm_min = 6'd3;
        #10;
        clk_reset = 1'b0;

        // Step 4: Run simulation to verify counting and alarm behavior under reset
        #50000;

        `ifdef CADENCE
            $shm_close();
        `endif

        $display("[INFO] Top module simulation completed successfully.");
        #500 $finish;
    end

endmodule
