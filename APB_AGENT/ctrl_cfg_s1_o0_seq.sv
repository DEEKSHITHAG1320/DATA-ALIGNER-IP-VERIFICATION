`ifndef CTRL_CFG_S1_O0_SEQ_SV
`define CTRL_CFG_S1_O0_SEQ_SV

class ctrl_cfg_s1_o0_seq extends apb_base_seq;
  `uvm_object_utils(ctrl_cfg_s1_o0_seq)
  
  function new(string name = "ctrl_cfg_s1_o0_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h0000;
   // req.pwdata = 32'h00000001; //size = 1 and offset = 0
   // req.pwdata = 32'h00000101; //size = 1 and offset = 1
   // req.pwdata = 32'h00000201; //size = 1 and offset = 2
   // req.pwdata = 32'h00000301; //size = 1 and offset = 3
   // req.pwdata = 32'h00000002; //size = 2 and offset = 0
   // req.pwdata = 32'h00000202; //size = 2 and offset = 2
    req.pwdata = 32'h00000004; //size = 4 and offset = 0
    finish_item(req);
  endtask
  
endclass

`endif