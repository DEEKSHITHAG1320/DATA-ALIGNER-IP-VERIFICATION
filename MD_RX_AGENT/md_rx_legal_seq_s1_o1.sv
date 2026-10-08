`ifndef MD_RX_LEGAL_SEQ_S1_O1_SV 
`define MD_RX_LEGAL_SEQ_S1_O1_SV

class md_rx_legal_seq_s1_o1 extends md_rx_base_seq;
  `uvm_object_utils(md_rx_legal_seq_s1_o1)
  
  function new(string name = "md_rx_legal_seq_s1_o1");
    super.new(name);
  endfunction
  
  task body();
    req = md_rx_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.data = 32'hAABBCCDD;
    req.size = 1;
    req.offset = 1;
    
    finish_item(req);
  endtask
  
endclass

`endif