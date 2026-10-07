`ifndef RESERVED_FIELDS_VSEQ_SV
`define RESERVED_FIELDS_VSEQ_SV

class reserved_fields_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(reserved_fields_vseq)
  
  ctrl_reserved_seq		ctrl_wr_h;
  irqen_reserved_seq	irqen_wr_h;
  irq_reserved_seq		irq_wr_h;
  
  ctrl_read_seq			ctrl_rd_h;
  irqen_read_seq		irqen_rd_h;
  irq_read_seq			irq_rd_h;
  status_read_seq		status_rd_h;
  
  function new(string name = "reserved_fields_vseq");
    super.new(name);
  endfunction
  
  task body();
    //ctrl register
    ctrl_wr_h = ctrl_reserved_seq :: type_id :: create("ctrl_wr_h");
    ctrl_wr_h.start(v_seqrh.apb_seqrh);
    
    ctrl_rd_h = ctrl_read_seq :: type_id :: create("ctrl_rd_h");
    ctrl_rd_h.start(v_seqrh.apb_seqrh);
    
    //irqen register
    irqen_wr_h = irqen_reserved_seq :: type_id :: create("irqen_wr_h");
    irqen_wr_h.start(v_seqrh.apb_seqrh);
    
    irqen_rd_h = irqen_read_seq :: type_id :: create("irqen_rd_h");
    irqen_rd_h.start(v_seqrh.apb_seqrh);
    
    //irq register
    irq_wr_h = irq_reserved_seq :: type_id :: create("irq_wr_h");
    irq_wr_h.start(v_seqrh.apb_seqrh);
    
    irq_rd_h = irq_read_seq :: type_id :: create("irq_rd_h");
    irq_rd_h.start(v_seqrh.apb_seqrh);
    
    //status register
    status_rd_h = status_read_seq :: type_id :: create("status_rd_h");
    status_rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif