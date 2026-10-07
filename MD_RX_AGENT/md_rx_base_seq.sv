`ifndef MD_RX_BASE_SEQ_SV
`define MD_RX_BASE_SEQ_SV

class md_rx_base_seq extends uvm_sequence#(md_rx_xtn);
  `uvm_object_utils(md_rx_base_seq)
  
  function new(string name = "md_rx_base_seq");
    super.new(name);
  endfunction
  
endclass

`endif
