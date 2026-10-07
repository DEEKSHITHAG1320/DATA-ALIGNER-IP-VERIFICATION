`ifndef APB_BASE_SEQ_SV
`define APB_BASE_SEQ_SV

class apb_base_seq extends uvm_sequence#(apb_xtn);
  `uvm_object_utils(apb_base_seq)
  
  function new(string name = "apb_base_seq");
    super.new(name);
  endfunction
  
endclass

`endif