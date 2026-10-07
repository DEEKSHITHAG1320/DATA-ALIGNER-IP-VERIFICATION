`ifndef IRQEN_MAXDROP_ENABLE_SEQ_SV
`define IRQEN_MAXDROP_ENABLE_SEQ_SV

class irqen_maxdrop_enable_seq extends apb_base_seq;
  `uvm_object_utils(irqen_maxdrop_enable_seq)
  
  function new(string name = "irqen_maxdrop_enable_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h00F0;
    req.pwdata = 32'h0000_0010;  // IRQEN[4]=MAX_DROP
    
    finish_item(req);
  endtask
  
endclass


`endif