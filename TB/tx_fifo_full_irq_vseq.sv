`ifndef TX_FIFO_FULL_IRQ_VSEQ_SV
`define TX_FIFO_FULL_IRQ_VSEQ_SV

class tx_fifo_full_irq_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(tx_fifo_full_irq_vseq)
  
  irqen_tx_full_enable_seq		irqen_h;
  ctrl_cfg_s4_o0_seq			cfg_h;
  md_tx_not_ready_seq			not_ready_h;
  md_rx_legal_pkt_seq			legal_h;
  irq_read_seq					rd_h;
  irq_clear_tx_full_seq			clr_h;
  
  function new(string name = "tx_fifo_full_irq_vseq");
    super.new(name);
  endfunction
  
  task body();
    //Enable tx_fifo_full 
    irqen_h = irqen_tx_full_enable_seq :: type_id :: create("irqen_h");
    irqen_h.start(v_seqrh.apb_seqrh);
    
    //configure DUT
    cfg_h = ctrl_cfg_s4_o0_seq	:: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //block TX side
    not_ready_h = md_tx_not_ready_seq :: type_id :: create("not_ready_h");
    not_ready_h.start(v_seqrh.md_tx_seqrh);
    
    //send valid pkts 
    repeat(10)
      begin
        legal_h = md_rx_legal_pkt_seq :: type_id :: create("legal_h");
        legal_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //read from IRQ register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //clear IRQ register
    clr_h = irq_clear_tx_full_seq :: type_id :: create("clr_h");
    clr_h.start(v_seqrh.apb_seqrh);
    
    //read again from IRQ register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass
    
`endif