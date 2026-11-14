// =============================================================================
// Testbench: clock_tb
// Course: EEE411L - VLSI Design Laboratory
// Description: Testbench verifying clock module counting and reset operation.
// =============================================================================

`timescale 1ns / 1ps

module clock_tb;

    reg        clk;
    reg        reset;
    reg  [5:0] reset_min;
    reg  [4:0] reset_hour;
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hour;

    // Instantiate Design Under Test (DUT)
    clock_module dut (
        .clk        (clk),
        .reset      (reset),
        .reset_min  (reset_min),
        .reset_hour (reset_hour),
        .sec        (sec),
        .min        (min),
        .hour       (hour)
    );

    // Clock generator: 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Waveform dumping for standard VCD / GTKWave
        $dumpfile("clock_tb.vcd");
        $dumpvars(0, clock_tb);

        `ifdef CADENCE
            $shm_open("shm.db", 1);
            $shm_probe("AS");
        `endif

        // Initialization
        reset = 1'b1;
        reset_hour = 5'd4;
        reset_min  = 6'd12;
        #10;

        // Deassert reset to start counting
        reset = 1'b0;
        #6000;

        // Reassert reset
        reset = 1'b1;
        #500;

        // Resume counting
        reset = 1'b0;
        #10000;

        `ifdef CADENCE
            $shm_close();
        `endif

        $display("[INFO] Clock module simulation completed successfully.");
        $finish;
    end

endmodule
