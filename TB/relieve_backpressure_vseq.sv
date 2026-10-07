`ifndef RELIEVE_BACKPRESSURE_VSEQ_SV
`define RELIEVE_BACKPRESSURE_VSEQ_SV

class relieve_backpressure_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(relieve_backpressure_vseq)
  
  ctrl_cfg_s2_o0_seq		cfg_h;
  md_tx_not_ready_seq		tx_block_h;
  md_tx_ready_seq			tx_release_h;
  md_rx_valid_pkt_seq		rx_h;
  status_read_seq			rd_h;
  
  function new(string name = "relieve_backpressure_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //configure DUT 
    cfg_h = ctrl_cfg_s2_o0_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //apply backpressure
    tx_block_h = md_tx_not_ready_seq :: type_id :: create("tx_block_h");
    tx_block_h.start(v_seqrh.md_tx_seqrh);
    
    //send 10 packets 
    repeat(10)
      begin
        rx_h = md_rx_valid_pkt_seq :: type_id :: create("rx_h");
        rx_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //read status
    rd_h = status_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //release backpressure
    tx_release_h = md_tx_ready_seq :: type_id :: create("tx_release_h");
    tx_release_h.start(v_seqrh.md_tx_seqrh);
    
    #100ns;
    
    //Read status again 
    rd_h = status_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
  endtask
  
endclass

`endif