`ifndef TX_RX_LVL_VSEQ_SV
`define TX_RX_LVL_VSEQ_SV

class tx_rx_lvl_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(tx_rx_lvl_vseq)
  
  ctrl_cfg_seq				cfg_h;
  md_tx_not_ready_seq		tx_not_ready_h;
  md_rx_legal_pkt_seq		rx_legal_pkt_h;
  status_read_seq			rd_h;
  
  function new(string name = "tx_rx_lvl_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //configure CTRL Register fields
    cfg_h = ctrl_cfg_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //Block TX side
    tx_not_ready_h = md_tx_not_ready_seq :: type_id :: create("tx_not_ready_h");
    tx_not_ready_h.start(v_seqrh.md_tx_seqrh);
    
    //Send 8 legal pkts 
    repeat(8)
      begin
        rx_legal_pkt_h = md_rx_legal_pkt_seq :: type_id :: create("rx_legal_pkt_h");
        rx_legal_pkt_h.start(v_seqrh.md_rx_seqrh);
        
        //Read STATUS after each packet
        rd_h = status_read_seq :: type_id :: create("rd_h");
        rd_h.start(v_seqrh.apb_seqrh);
      end
  endtask
  
endclass

`endif