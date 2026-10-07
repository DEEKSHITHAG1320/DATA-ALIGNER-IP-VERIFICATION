`ifndef IRQEN_RW_VSEQ_SV
`define IRQEN_RW_VSEQ_SV

class irqen_rw_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(irqen_rw_vseq)
  
  irqen_write_all1_seq 	wr1_h;
  irqen_write_all0_seq  wr0_h;
  irqen_read_seq		rd_h;
  
  function new(string name = "irqen_rw_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //write all 1's
    wr1_h = irqen_write_all1_seq :: type_id :: create("wr1_h");
    wr1_h.start(v_seqrh.apb_seqrh);
    
    //read back
    rd_h = irqen_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    #30ns;
    
    //write all 0's
    wr0_h = irqen_write_all0_seq ::type_id :: create("wr0_h");
    wr0_h.start(v_seqrh.apb_seqrh);
    
    //read back
    rd_h = irqen_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
  endtask
  
endclass

`endif