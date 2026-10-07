`ifndef MD_TX_BASE_SEQ_SV
`define MD_TX_BASE_SEQ_SV

class md_tx_base_seq extends uvm_sequence#(md_tx_xtn);
  `uvm_object_utils(md_tx_base_seq)
  
  function new(string name = "md_tx_base_seq");
    super.new(name);
  endfunction
  
endclass

`endif
