`ifndef MD_TX_NOT_READY_SEQ_SV
`define MD_TX_NOT_READY_SEQ_SV

class md_tx_not_ready_seq extends md_tx_base_seq;
  `uvm_object_utils(md_tx_not_ready_seq)
  
  function new(string name = "md_tx_not_ready_seq");
    super.new(name);
  endfunction
  
  task body();
    req = md_tx_xtn :: type_id :: create("req");
    
    start_item(req);
    req.ready = 1'b0;
    finish_item(req);
  endtask
  
endclass

`endif