/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_jtag (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
    assign uo_out[7:3] = 5'b0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, ui_in[7:4], uio_in[7:0], 1'b0};

    tt_um_jtag_top #(.IMEM_INIT_FILE("Memory/riscvtest.mem")) top(
        .tck(clk),
        .tdi(ui_in[0]),
        .tms(ui_in[1]),
        .trst(rst_n),
        .tdo(uo_out[0]),
        .sysclk(ui_in[2]),
        .sys_reset(ui_in[3]),
        .success(uo_out[1]),
        .fail(uo_out[2])
    );
        

endmodule
