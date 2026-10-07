`ifndef CTRL_CLR_ONE_SEQ_SV
`define CTRL_CLR_ONE_SEQ_SV

class ctrl_clr_one_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_clr_one_seq)
  
  function new(string name = "ctrl_clr_one_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'h00010001;
    
    finish_item(req);
  endtask
  
endclass

`endif