`ifndef IRQEN_RX_EMPTY_ENABLE_SEQ_SV
`define IRQEN_RX_EMPTY_ENABLE_SEQ_SV

class irqen_rx_empty_enable_seq extends apb_base_seq;
  `uvm_object_utils(irqen_rx_empty_enable_seq)
  
  function new(string name = "irqen_rx_empty_enable_seq");
    super.new(name);
  endfunction
  
  task body();
    req = apb_xtn :: type_id :: create("req");
    
    start_item(req);
    
    req.pwrite = 1;
    req.paddr = 16'h00F0;
    req.pwdata = 32'h00000001;//IRQEN[0] = RX_FIFO_EMPTY_ENABLE
    
    finish_item(req);
  endtask
  
endclass

`endif