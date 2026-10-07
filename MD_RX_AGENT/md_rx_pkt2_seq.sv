`ifndef MD_RX_PKT2_SEQ_SV 
`define MD_RX_PKT2_SEQ_SV

class md_rx_pkt2_seq extends md_rx_base_seq;
  `uvm_object_utils(md_rx_pkt2_seq)
  
  function new(string name = "md_rx_pkt2_seq");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = 32'h11111111;
    req.size = 1;
    req.offset = 0;
    
    finish_item(req);
  endtask
  
endclass

`endif