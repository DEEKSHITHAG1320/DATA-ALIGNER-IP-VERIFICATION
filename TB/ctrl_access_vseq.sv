`ifndef CTRL_ACCESS_VSEQ_SV
`define CTRL_ACCESS_VSEQ_SV

class ctrl_access_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(ctrl_access_vseq)
  
  ctrl_rw_write_seq		wr_h;
  ctrl_read_seq			rd_h;
  ctrl_clr_wo_seq		clr_h;
  
  function new(string name = "ctrl_access_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //verify SIZE & OFFSET RW access
    wr_h = ctrl_rw_write_seq :: type_id :: create("wr_h");
    wr_h.start(v_seqrh.apb_seqrh);
    
    rd_h = ctrl_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
    
    //verify CLR WO access
    clr_h = ctrl_clr_wo_seq :: type_id :: create("clr_h");
    clr_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif