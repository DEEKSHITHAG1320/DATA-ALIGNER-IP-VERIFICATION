`ifndef MD_RX_ALIGNMENT_SEQ_SV
`define MD_RX_ALIGNMENT_SEQ_SV

class md_rx_alignment_seq extends md_rx_base_seq;
  `uvm_object_utils(md_rx_alignment_seq)
  
  function new(string name = "md_rx_alignment_seq");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = 32'hAABBCCDD;
  //  req.size = 1; req.offset = 0;
  //  req.size = 1; req.offset = 1;
  //  req.size = 1; req.offset = 2;
  //  req.size = 1; req.offset = 3;
    
   // req.size = 2; req.offset = 0;
   // req.size = 2; req.offset = 2;
    
    req.size = 4; req.offset = 0;
    
    finish_item(req);
  endtask
  
endclass

`endif