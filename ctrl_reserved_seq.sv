`ifndef CTRL_RESERVED_SEQ_SV
`define CTRL_RESERVED_SEQ_SV

class ctrl_reserved_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_reserved_seq)
  
  function new(string name = "ctrl_reserved_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'hFFFF0202; //writing all ones to reserved fileds
    
    finish_item(req);
  endtask
  
endclass

`endif