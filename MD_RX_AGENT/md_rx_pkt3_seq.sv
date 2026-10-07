`ifndef MD_RX_PKT3_SEQ_SV 
`define MD_RX_PKT3_SEQ_SV

class md_rx_pkt3_seq extends md_rx_base_seq;
  `uvm_object_utils(md_rx_pkt3_seq)
  
  function new(string name = "md_rx_pkt3_seq");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = 32'hBBBBBBBB;
    req.size = 1;
    req.offset = 0;
    
    finish_item(req);
  endtask
  
endclass

`endif