`ifndef INTERLEAVING_TXN_VSEQ_SV
`define INTERLEAVING_TXN_VSEQ_SV

class interleaving_txn_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(interleaving_txn_vseq)
  
  ctrl_cfg_s2_o0_seq	cfg_h;
  
  md_rx_valid_pkt_seq	valid_h;
  md_rx_invalid_pkt_seq	invalid_h;
  
  md_tx_ready_seq	tx_h;
  
  status_read_seq	rd_h;
  
  function new(string name = "interleaving_txn_vseq");
    super.new(name);
  endfunction
  
  task body();
    //configure DUT
    cfg_h = ctrl_cfg_s2_o0_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //enable TX
    tx_h = md_tx_ready_seq :: type_id ::create("tx_h");
    tx_h.start(v_seqrh.md_tx_seqrh);
    
    //valid pkt
    valid_h = md_rx_valid_pkt_seq :: type_id :: create("valid_h");
    valid_h.start(v_seqrh.md_rx_seqrh);
    
    //invalid pkt
    invalid_h = md_rx_invalid_pkt_seq :: type_id :: create("invalid_h");
    invalid_h.start(v_seqrh.md_rx_seqrh);
    
    //valid pkt
    valid_h = md_rx_valid_pkt_seq :: type_id :: create("valid_h");
    valid_h.start(v_seqrh.md_rx_seqrh);
    
     //invalid pkt
    invalid_h = md_rx_invalid_pkt_seq :: type_id :: create("invalid_h");
    invalid_h.start(v_seqrh.md_rx_seqrh);
    
     //valid pkt
    valid_h = md_rx_valid_pkt_seq :: type_id :: create("valid_h");
    valid_h.start(v_seqrh.md_rx_seqrh);
    
     //invalid pkt
    invalid_h = md_rx_invalid_pkt_seq :: type_id :: create("invalid_h");
    invalid_h.start(v_seqrh.md_rx_seqrh);
    
    //read status
    rd_h = status_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
  endtask
  
endclass

`endif