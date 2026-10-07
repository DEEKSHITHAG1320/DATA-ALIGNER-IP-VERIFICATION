`ifndef IRQ_CLEAR_MAXDROP_SEQ_SV
`define IRQ_CLEAR_MAXDROP_SEQ_SV

class irq_clear_maxdrop_seq extends apb_base_seq;
  `uvm_object_utils(irq_clear_maxdrop_seq)
  
  function new(string name = "irq_clear_maxdrop_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn ::type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1;
    req.paddr = 16'h00F4;
    req.pwdata = 32'h00000010;
    
    finish_item(req);
  endtask
  
endclass

`endif