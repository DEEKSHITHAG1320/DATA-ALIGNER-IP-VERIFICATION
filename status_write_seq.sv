`ifndef STATUS_WRITE_SEQ_SV
`define STATUS_WRITE_SEQ_SV

class status_write_seq extends apb_base_seq;
  `uvm_object_utils(status_write_seq)
  
  function new(string name = "status_write_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h000C;
    req.pwdata = 32'hFFFFFFFF;
    
    finish_item(req);
  endtask
  
endclass

`endif