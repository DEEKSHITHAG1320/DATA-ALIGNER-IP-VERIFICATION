`ifndef RX_FIFO_EMPTY_IRQ_VSEQ_SV
`define RX_FIFO_EMPTY_IRQ_VSEQ_SV

class rx_fifo_empty_irq_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(rx_fifo_empty_irq_vseq)
  
  irqen_rx_empty_enable_seq 	irqen_h;
  ctrl_cfg_s4_o0_seq			cfg_h;
  md_tx_ready_seq				ready_h;
  md_rx_legal_pkt_seq			legal_h;
  irq_read_seq					rd_h;
  irq_clear_rx_empty_seq		clr_h;
  
  function new(string name = "rx_fifo_empty_irq_vseq");
    super.new(name);
  endfunction
  
  task body();
    //enable empty from IRQEN register
    irqen_h = irqen_rx_empty_enable_seq :: type_id :: create("irqen_h");
    irqen_h.start(v_seqrh.apb_seqrh);
    
    //configure DUT 
    cfg_h = ctrl_cfg_s4_o0_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //enable tx side
    ready_h = md_tx_ready_seq :: type_id :: create("ready_h");
    ready_h.start(v_seqrh.md_tx_seqrh);
    
    //send valid pkt to DUT 
    legal_h = md_rx_legal_pkt_seq :: type_id :: create("legal_h");
    legal_h.start(v_seqrh.md_rx_seqrh);
    
    //read from IRQ register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //clear irq rx_fifo_empty
    clr_h = irq_clear_rx_empty_seq :: type_id :: create("clr_h");
    clr_h.start(v_seqrh.apb_seqrh);
    
    //read again from IRQ register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    ready_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif