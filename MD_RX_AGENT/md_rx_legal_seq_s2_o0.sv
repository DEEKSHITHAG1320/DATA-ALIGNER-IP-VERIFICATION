`ifndef MD_RX_LEGAL_SEQ_S2_O0_SV 
`define MD_RX_LEGAL_SEQ_S2_O0_SV

class md_rx_legal_seq_s2_o0 extends md_rx_base_seq;
  `uvm_object_utils(md_rx_legal_seq_s2_o0)
  
  function new(string name = "md_rx_legal_seq_s2_o0");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = 32'hAABBCCDD;
    req.size = 2;
    req.offset = 0;
    
    finish_item(req);
  endtask
  
endclass

`endif