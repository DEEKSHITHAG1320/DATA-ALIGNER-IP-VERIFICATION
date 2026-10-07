`ifndef CTRL_CLR_WO_SEQ_SV
`define CTRL_CLR_WO_SEQ_SV

class ctrl_clr_wo_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_clr_wo_seq)
  
  function new(string name = "ctrl_clr_wo_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite =1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'h00010202; //CLR=1; OFFSET=2; SIZE=2
    
    finish_item(req);
  endtask
  
endclass

`endif