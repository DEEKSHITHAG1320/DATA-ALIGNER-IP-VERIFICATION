`ifndef IRQ_RESERVED_SEQ_SV
`define IRQ_RESERVED_SEQ_SV

class irq_reserved_seq extends apb_base_seq;
  `uvm_object_utils(irq_reserved_seq)
  
  function new(string name = "irq_reserved_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h00F4;
    req.pwdata = 32'hFFFFFFFF;
    
    finish_item(req);
  endtask
  
endclass

`endif