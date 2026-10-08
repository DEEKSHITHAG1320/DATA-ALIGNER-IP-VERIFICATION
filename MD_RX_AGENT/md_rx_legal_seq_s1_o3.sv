`ifndef MD_RX_LEGAL_SEQ_S1_O3_SV 
`define MD_RX_LEGAL_SEQ_S1_O3_SV

class md_rx_legal_seq_s1_o3 extends md_rx_base_seq;
  `uvm_object_utils(md_rx_legal_seq_s1_o3)
  
  function new(string name = "md_rx_legal_seq_s1_o3");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = 32'hAABBCCDD;
    req.size = 1;
    req.offset = 3;
    
    finish_item(req);
  endtask
  
endclass

`endif