`ifndef RX_FIFO_FULL_IRQ_VSEQ_SV
`define RX_FIFO_FULL_IRQ_VSEQ_SV

class rx_fifo_full_irq_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(rx_fifo_full_irq_vseq)
  
  irqen_rx_full_enable_seq		rx_full_enable_h;
  ctrl_cfg_s4_o0_seq			cfg_h;
  md_tx_not_ready_seq			not_ready_h;
  md_rx_legal_pkt_seq			legal_h;
  irq_read_seq					rd_h;
  
  function new(string name = "rx_fifo_full_irq_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //enable rx fifo full 
    rx_full_enable_h = irqen_rx_full_enable_seq :: type_id :: create("rx_full_enable_h");
    rx_full_enable_h.start(v_seqrh.apb_seqrh);
    
    //configure DUT offset and size
    cfg_h = ctrl_cfg_s4_o0_seq :: type_id :: create("cfg_h");
    cfg_h.start(v_seqrh.apb_seqrh);
    
    //block TX side
    not_ready_h = md_tx_not_ready_seq :: type_id :: create("not_ready_h");
    not_ready_h.start(v_seqrh.md_tx_seqrh);
    
    //send 10 legal pkts 
    repeat(18)
      begin
        legal_h = md_rx_legal_pkt_seq :: type_id :: create("legal_h");
        legal_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //read from IRQ register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif