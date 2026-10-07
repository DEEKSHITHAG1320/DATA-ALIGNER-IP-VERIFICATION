`ifndef IRQEN_TX_EMPTY_ENABLE_SEQ_SV
`define IRQEN_TX_EMPTY_ENABLE_SEQ_SV

class irqen_tx_empty_enable_seq extends apb_base_seq;
  `uvm_object_utils(irqen_tx_empty_enable_seq)
  
  function new(string name = "irqen_tx_empty_enable_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1;
    req.paddr = 16'h00F0;
    req.pwdata = 32'h00000004;	//IRQEN[2]=TX_FIFO_EMPTY
    
    finish_item(req);
  endtask
  
endclass

`endif