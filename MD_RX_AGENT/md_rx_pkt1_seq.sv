`ifndef MD_RX_PKT1_SEQ_SV 
`define MD_RX_PKT1_SEQ_SV

class md_rx_pkt1_seq extends md_rx_base_seq;
  `uvm_object_utils(md_rx_pkt1_seq)
  
  function new(string name = "md_rx_pkt1_seq");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
   // req.data = 32'hAABBCCDD;
    req.data = 32'hAAAAAAAA;
    req.size = 1;
    req.offset = 0;
    
    finish_item(req);
  endtask
  
endclass

`endif