`ifndef DATA_ALIGNMENT_VSEQ_SV
`define DATA_ALIGNMENT_VSEQ_SV

class data_alignment_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(data_alignment_vseq)
  
  ctrl_cfg_s1_o0_seq 	cfg_h;
  md_rx_alignment_seq	rx_h;
  md_tx_ready_seq		tx_h;
  
  function new(string name = "data_alignment_vseq");
    super.new(name);
  endfunction
  
  task body();
    //configure CTRL
    cfg_h = ctrl_cfg_s1_o0_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //enable TX 
    tx_h = md_tx_ready_seq :: type_id :: create("tx_h");
    tx_h.start(v_seqrh.md_tx_seqrh);
    
    //send packet
    rx_h = md_rx_alignment_seq :: type_id :: create("rx_h");
    rx_h.start(v_seqrh.md_rx_seqrh);
  endtask
  
endclass

`endif