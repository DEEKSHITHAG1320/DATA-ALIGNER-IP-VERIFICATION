`ifndef ALGN_PKG_SV
`define ALGN_PKG_SV

`include "uvm_macros.svh"
`include "apb_pkg.sv"
`include "md_pkg.sv"

package algn_pkg;

parameter int DATA_WIDTH = 32;

import uvm_pkg::*;

import apb_pkg::*;
import md_pkg::*;

`include "algn_virtual_sequencer.sv"
`include "algn_virtual_base_sequence.sv"

`include "algn_scoreboard.sv"
`include "algn_coverage.sv"

`include "algn_env.sv"

`include "ctrl_clr_zero_seq.sv"
`include "clr_write0_vseq.sv"

`include "ctrl_clr_one_seq.sv"
`include "clr_write1_vseq.sv"

`include "irqen_rw_vseq.sv"
`include "irq_w1c_vseq.sv"

`include "status_ro_vseq.sv"

`include "ctrl_access_vseq.sv"

`include "tx_rx_lvl_vseq.sv"

`include "reserved_fields_vseq.sv"

`include "data_alignment_vseq.sv"

`include "interleaving_txn_vseq.sv"

`include "relieve_backpressure_vseq.sv"

`include "controller_storage_vseq.sv"

`include "max_drop_irq_vseq.sv"

`include "rx_fifo_full_irq_vseq.sv"

`include "rx_fifo_empty_irq_vseq.sv"

`include "tx_fifo_full_irq_vseq.sv"

`include "tx_fifo_empty_irq_vseq.sv"

`include "multiple_interrupts_vseq.sv"

`include "algn_cov_vseq.sv"
endpackage

`endif
