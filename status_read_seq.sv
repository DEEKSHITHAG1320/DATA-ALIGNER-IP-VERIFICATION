`ifndef STATUS_READ_SEQ_SV
`define STATUS_READ_SEQ_SV

class status_read_seq extends apb_base_seq;
  `uvm_object_utils(status_read_seq)
  
  function new(string name = "status_read_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b0;
    req.paddr = 16'h000C;
    req.pwdata = 32'h0;
    
    finish_item(req);
  endtask
  
endclass
    

`endif