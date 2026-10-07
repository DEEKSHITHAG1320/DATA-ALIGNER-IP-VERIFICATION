`ifndef MD_RX_LEGAL_PKT_SEQ_SV
`define MD_RX_LEGAL_PKT_SEQ_SV

class md_rx_legal_pkt_seq extends md_rx_base_seq;
  `uvm_object_utils(md_rx_legal_pkt_seq)
  
  function new(string name = "md_rx_legal_pkt_seq");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = $urandom;
    req.size = 4;
    req.offset = 0;
    
    finish_item(req);
  endtask
  
endclass

`endif