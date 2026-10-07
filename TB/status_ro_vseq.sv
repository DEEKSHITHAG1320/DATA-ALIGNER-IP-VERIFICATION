`ifndef STATUS_RO_VSEQ_SV
`define STATUS_RO_VSEQ_SV

class status_ro_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(status_ro_vseq)
  
  status_write_seq 	wr_h;
  status_read_seq 	rd_h;
  
  function new(string name = "status_ro_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    //Illegal write to status register
    wr_h = status_write_seq :: type_id :: create("wr_h");
    wr_h.start(v_seqrh.apb_seqrh);
    
    //read status register
    rd_h = status_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif