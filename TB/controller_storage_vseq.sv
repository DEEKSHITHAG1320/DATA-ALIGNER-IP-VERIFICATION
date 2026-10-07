`ifndef CONTROLLER_STORAGE_VSEQ_SV
`define CONTROLLER_STORAGE_VSEQ_SV

class controller_storage_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(controller_storage_vseq)
  
  md_tx_ready_seq	tx_h;
  ctrl_cfg_s4_o0_seq	cfg_h;
  md_rx_pkt1_seq		pkt1_h;
  md_rx_pkt2_seq		pkt2_h;
  md_rx_pkt3_seq		pkt3_h;
  md_rx_pkt4_seq		pkt4_h;
  
  function new(string name = "controller_storage_vseq");
    super.new(name);
  endfunction
  
  task body();
    cfg_h = ctrl_cfg_s4_o0_seq	:: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    tx_h = md_tx_ready_seq	:: type_id :: create("tx_h");
    tx_h.start(v_seqrh.md_tx_seqrh);
    
    pkt1_h = md_rx_pkt1_seq :: type_id :: create("pkt1_h");
    pkt1_h.start(v_seqrh.md_rx_seqrh);
    
    pkt2_h = md_rx_pkt2_seq :: type_id :: create("pkt2_h");
    pkt2_h.start(v_seqrh.md_rx_seqrh);
    
    pkt3_h = md_rx_pkt3_seq :: type_id :: create("pkt3_h");
    pkt3_h.start(v_seqrh.md_rx_seqrh);
    
    pkt4_h = md_rx_pkt4_seq :: type_id :: create("pkt4_h");
    pkt4_h.start(v_seqrh.md_rx_seqrh);
  endtask
  
endclass

`endif