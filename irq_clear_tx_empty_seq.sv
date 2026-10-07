`ifndef IRQ_CLEAR_TX_EMPTY_SEQ_SV
`define IRQ_CLEAR_TX_EMPTY_SEQ_SV

class irq_clear_tx_empty_seq extends apb_base_seq;
  `uvm_object_utils(irq_clear_tx_empty_seq)
  
  function new(string name = "irq_clear_tx_empty_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1;
    req.paddr =16'h00F4;
    req.pwdata = 32'h00000004;

    finish_item(req);
  endtask
  
endclass

`endif