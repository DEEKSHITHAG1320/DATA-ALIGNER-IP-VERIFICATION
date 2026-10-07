`ifndef ALGN_TEST_PKG_SV
 `define ALGN_TEST_PKG_SV

`include "uvm_macros.svh"
`include "algn_pkg.sv"
`include "md_pkg.sv"

package algn_test_pkg;

parameter int DATA_WIDTH = 32;

import uvm_pkg::*;
import algn_pkg::*;
import apb_pkg::*;
import md_pkg::*;


`include "algn_test_base.sv"
`include "algn_test_clr_write0.sv"
`include "algn_test_clr_write1.sv"
`include "algn_test_irqen_rw.sv"
`include "algn_test_irq_w1c.sv"
`include "algn_test_status_ro.sv"
`include "algn_test_ctrl_access.sv"
`include "algn_test_tx_rx_lvl.sv"
`include "algn_test_reserved_fields.sv"
`include "algn_test_data_alignment.sv"
`include "algn_test_interleaving_txn.sv"
`include "algn_test_relieve_backpressure.sv"
`include "algn_test_controller_storage.sv"
`include "algn_test_max_drop_irq.sv"
`include "algn_test_rx_fifo_full_irq.sv"
`include "algn_test_rx_fifo_empty_irq.sv"
`include "algn_test_tx_fifo_full_irq.sv"
`include "algn_test_tx_fifo_empty_irq.sv"
`include "algn_test_multiple_interrupts.sv"
endpackage

`endif