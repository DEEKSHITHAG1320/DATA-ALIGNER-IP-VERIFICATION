`ifndef MD_TX_SEQUENCER_SV
`define MD_TX_SEQUENCER_SV

class md_tx_sequencer extends uvm_sequencer#(md_tx_xtn);
  `uvm_component_utils(md_tx_sequencer)
  
  function new(string name = "md_tx_sequencer" ,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
endclass

`endif