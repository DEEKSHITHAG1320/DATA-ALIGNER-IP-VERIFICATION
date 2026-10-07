`ifndef IRQ_WRITE_ZERO_SEQ_SV 
`define IRQ_WRITE_ZERO_SEQ_SV

class irq_write_zero_seq extends apb_base_seq;
  `uvm_object_utils(irq_write_zero_seq)
  
  function new(string name = "irq_write_zero_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1'b1;
    req.paddr = 16'h00F4;
    req.pwdata = 32'h0;
    
    finish_item(req);
  endtask
  
endclass      

`endif