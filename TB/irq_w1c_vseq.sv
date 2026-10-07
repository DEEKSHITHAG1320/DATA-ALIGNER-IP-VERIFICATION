`ifndef IRQ_W1C_VSEQ_SV
`define IRQ_W1C_VSEQ_SV

class irq_w1c_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(irq_w1c_vseq)
  
  
  irqen_maxdrop_enable_seq 		irqen_maxdrop_seqh;
  md_rx_illegal_pkt_seq			rx_illegal_seqh;
  
  irq_read_seq 		rd_h;
  irq_write_zero_seq	wr0_h;
  irq_clear_maxdrop_seq clr_h;
  
  function new(string name = "irq_w1c_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    // enable MAX_DROP interrupt
    irqen_maxdrop_seqh = irqen_maxdrop_enable_seq :: type_id :: create("irqen_maxdrop_seqh");
    irqen_maxdrop_seqh.start(v_seqrh.apb_seqrh);
    
    //Generate 255 illegal packets
    repeat(255)
      begin
        rx_illegal_seqh = md_rx_illegal_pkt_seq :: type_id :: create("rx_illegal_seqh");
        rx_illegal_seqh.start(v_seqrh.md_rx_seqrh);
      end
    
    //read IRQ register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //write 0 to IRQ[MAX_DROP]
    wr0_h = irq_write_zero_seq :: type_id :: create("wr0_h");
    wr0_h.start(v_seqrh.apb_seqrh);
    
    //read again
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //write 1 to clear IRQ[MAX_DROP]
    clr_h = irq_clear_maxdrop_seq :: type_id :: create("clr_h");
    clr_h.start(v_seqrh.apb_seqrh);
    
    //final read
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif
