`ifndef MD_RX_SEQUENCER_SV
`define MD_RX_SEQUENCER_SV

class md_rx_sequencer extends uvm_sequencer#(md_rx_xtn);
  `uvm_component_utils(md_rx_sequencer)
  
  function new(string name = "md_rx_sequencer" ,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
endclass

`endif