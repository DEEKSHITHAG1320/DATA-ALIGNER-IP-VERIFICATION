`ifndef CTRL_READ_SEQ_SV
`define CTRL_READ_SEQ_SV

class ctrl_read_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_read_seq)
  
  function new(string name = "ctrl_read_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b0;
    req.paddr = 16'h0000;
    req.pwdata = 32'h0;
    
    finish_item(req);
  endtask
  
endclass

`endif