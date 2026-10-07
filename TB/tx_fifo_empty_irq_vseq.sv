`ifndef TX_FIFO_EMPTY_IRQ_VSEQ_SV
`define TX_FIFO_EMPTY_IRQ_VSEQ_SV

class tx_fifo_empty_irq_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(tx_fifo_empty_irq_vseq)
  
  irqen_tx_empty_enable_seq 	irqen_h;
  ctrl_cfg_s4_o0_seq			cfg_h;
  md_tx_not_ready_seq			block_h;
  md_tx_ready_seq				release_h;
  md_rx_legal_pkt_seq			legal_h;
  irq_read_seq					rd_h;
  irq_clear_tx_empty_seq		clr_h;
  
  function new(string name = "tx_fifo_empty_irq_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //enable IRQEN register
    irqen_h = irqen_tx_empty_enable_seq :: type_id :: create("irqen_h");
    irqen_h.start(v_seqrh.apb_seqrh);
    
    //Configure DUT 
    cfg_h = ctrl_cfg_s4_o0_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //Block TX
    block_h = md_tx_not_ready_seq :: type_id :: create("block_h");
    block_h.start(v_seqrh.md_tx_seqrh);
    
    //Fill TX fifo 
    repeat(10)
      begin
        legal_h = md_rx_legal_pkt_seq :: type_id :: create("legal_h");
        legal_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //release TX fifo
    release_h = md_tx_ready_seq :: type_id :: create("release_h");
    release_h.start(v_seqrh.md_tx_seqrh);
    
    // allow fifo drain
    #300ns;
    
    //read IRQ 
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //Clear IRQ
    clr_h = irq_clear_tx_empty_seq :: type_id :: create("clr_h");
    clr_h.start(v_seqrh.apb_seqrh);
    
    //Read again 
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif