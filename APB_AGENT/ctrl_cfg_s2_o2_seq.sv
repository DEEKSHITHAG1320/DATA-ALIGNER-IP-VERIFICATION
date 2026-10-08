`ifndef CTRL_CFG_S2_O2_SEQ_SV
`define CTRL_CFG_S2_O2_SEQ_SV

class ctrl_cfg_s2_o2_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_cfg_s2_o2_seq)
  
  function new(string name = "ctrl_cfg_s2_o2_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
    req.pwdata = 32'h00000202; //size = 2 and offset = 2
  
    finish_item(req);
  endtask
  
endclass

`endif