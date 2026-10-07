`ifndef CTRL_CLR_ZERO_SEQ_SV
`define CTRL_CLR_ZERO_SEQ_SV

class ctrl_clr_zero_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_clr_zero_seq)
  
  function new(string name = "ctrl_clr_zero_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'h00000000;
    
    finish_item(req);
    
  endtask
  
endclass

`endif