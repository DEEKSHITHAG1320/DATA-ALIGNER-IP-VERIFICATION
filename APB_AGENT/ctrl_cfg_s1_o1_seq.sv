`ifndef CTRL_CFG_S1_O1_SEQ_SV
`define CTRL_CFG_S1_O1_SEQ_SV

class ctrl_cfg_s1_o1_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_cfg_s1_o1_seq)
  
  function new(string name = "ctrl_cfg_s1_o1_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'h00000101; //size = 1 and offset = 1

    finish_item(req);
  endtask
  
endclass

`endif