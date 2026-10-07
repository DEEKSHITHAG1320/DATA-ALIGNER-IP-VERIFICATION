`ifndef CTRL_RW_WRITE_SEQ_SV
`define CTRL_RW_WRITE_SEQ_SV

class ctrl_rw_write_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_rw_write_seq)
  
  function new(string name = "ctrl_rw_write_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'h00000202; //OFFSET = 2 & SIZE = 2
    
    finish_item(req);
  endtask
  
endclass

`endif