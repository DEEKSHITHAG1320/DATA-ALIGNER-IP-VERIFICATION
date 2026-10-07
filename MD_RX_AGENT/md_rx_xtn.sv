`ifndef MD_RX_XTN_SV
`define MD_RX_XTN_SV

class md_rx_xtn extends uvm_sequence_item;
  `uvm_object_utils(md_rx_xtn)
  
  localparam int unsigned DATA_WIDTH = 32;
  localparam int unsigned OFFSET_WIDTH = $clog2(DATA_WIDTH/8) < 1 ? 1 : $clog2(DATA_WIDTH/8);
  localparam int unsigned SIZE_WIDTH = $clog2(DATA_WIDTH/8)+1;

 rand logic[DATA_WIDTH-1 : 0] data;
 rand logic[OFFSET_WIDTH-1 : 0] offset;
 rand logic[SIZE_WIDTH-1 : 0] size;
  logic valid;
  logic ready;
  logic err;
  
  constraint vld_size { size > 0 ;}
  constraint vld_size1 { size <= (DATA_WIDTH/8);}
  constraint vld_offset{ offset < (DATA_WIDTH/8);}
  constraint vld_combination {size + offset <= (DATA_WIDTH/8);}
  
  function new(string name = "md_rx_xtn");
    super.new(name);
  endfunction
  
  function void do_print(uvm_printer printer);
    printer.print_field("DATA", this.data, DATA_WIDTH, UVM_HEX);
    printer.print_field("OFFSET", this.offset, OFFSET_WIDTH, UVM_DEC);
    printer.print_field("SIZE", this.size, SIZE_WIDTH, UVM_DEC);
    printer.print_field("VALID", this.valid, 1, UVM_DEC);
    printer.print_field("READY", this.ready, 1, UVM_DEC);
    printer.print_field("ERROR", this.err, 1, UVM_DEC);
  endfunction
 
endclass

`endif