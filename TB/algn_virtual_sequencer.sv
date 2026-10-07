`ifndef ALGN_VIRTUAL_SEQUENCER_SV
`define ALGN_VIRTUAL_SEQUENCER_SV

class algn_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(algn_virtual_sequencer)
  
  apb_sequencer apb_seqrh;
  md_rx_sequencer md_rx_seqrh;
  md_tx_sequencer md_tx_seqrh;
  
  function new (string name = "algn_virtual_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass

`endif