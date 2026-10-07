`ifndef MAX_DROP_IRQ_VSEQ_SV
`define MAX_DROP_IRQ_VSEQ_SV

class max_drop_irq_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(max_drop_irq_vseq)
  
  irqen_maxdrop_enable_seq	max_h;
  md_rx_illegal_pkt_seq		illegal_h;
  irq_read_seq				rd_h;
  
  function new(string name = "max_drop_irq_vseq");
    super.new(name);
  endfunction
  
  task body();
    //enable max drop irq
    max_h = irqen_maxdrop_enable_seq :: type_id :: create("max_h");
    max_h.start(v_seqrh.apb_seqrh);
    
    //255 illegal packets 
    repeat(255)
      begin
        illegal_h = md_rx_illegal_pkt_seq :: type_id :: create("illegal_h");
        illegal_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //read irq register
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif