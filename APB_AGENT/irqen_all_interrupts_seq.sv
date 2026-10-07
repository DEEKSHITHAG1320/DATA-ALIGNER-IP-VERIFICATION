`ifndef IRQEN_ALL_INTERRUPTS_SEQ_SV
`define IRQEN_ALL_INTERRUPTS_SEQ_SV

class irqen_all_interrupts_seq extends apb_base_seq;
  `uvm_object_utils(irqen_all_interrupts_seq)
  
  function new(string name = "irqen_all_interrupts_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1;
    req.paddr = 16'h00F0;
    req.pwdata = 32'h0000001F;
    
    finish_item(req);
  endtask
  
endclass

`endif