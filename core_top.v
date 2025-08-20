`timescale 1ns / 1ps

module core_top #(
    parameter MEMORY_FILE = ""
) (
    input  wire clk,
    input  wire rst_n
);

    wire [31:0] core_addr, core_wdata, core_rdata;
    wire        core_rd_en, core_wr_en;

    core core_inst (
        .clk     (clk),
        .rst_n   (rst_n),
        .addr_o  (core_addr),
        .data_o  (core_wdata),
        .data_i  (core_rdata),
        .rd_en_o (core_rd_en),
        .wr_en_o (core_wr_en)
    );

    Memory #(
        .MEMORY_FILE (MEMORY_FILE)
    ) mem (
        .clk      (clk),
        .rd_en_i  (core_rd_en),
        .wr_en_i  (core_wr_en),
        .addr_i   (core_addr),
        .data_i   (core_wdata),
        .data_o   (core_rdata),
        .ack_o    ()
    );

endmodule
