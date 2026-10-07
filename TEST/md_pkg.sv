`ifndef MD_PKG_SV
`define MD_PKG_SV

`include "uvm_macros.svh"
`include "md_if.sv"

package md_pkg;

parameter int DATA_WIDTH = 32;

import uvm_pkg::*;

`include "md_rx_agent_config.sv"
`include "md_tx_agent_config.sv"

`include "md_rx_xtn.sv"
`include "md_tx_xtn.sv"

`include "md_rx_base_seq.sv"
`include "md_rx_illegal_pkt_seq.sv"
`include "md_rx_legal_pkt_seq.sv"
`include "md_rx_alignment_seq.sv"
`include "md_rx_valid_pkt_seq.sv"
`include "md_rx_invalid_pkt_seq.sv"
`include "md_rx_pkt1_seq.sv"
`include "md_rx_pkt2_seq.sv"
`include "md_rx_pkt3_seq.sv"
`include "md_rx_pkt4_seq.sv"

`include "md_rx_sequencer.sv"
`include "md_rx_driver.sv"
`include "md_rx_monitor.sv"
`include "md_rx_agent.sv"

`include "md_tx_base_seq.sv"
`include "md_tx_not_ready_seq.sv"
`include "md_tx_ready_seq.sv"

`include "md_tx_sequencer.sv"
`include "md_tx_driver.sv"
`include "md_tx_monitor.sv"
`include "md_tx_agent.sv"

endpackage 

`endif