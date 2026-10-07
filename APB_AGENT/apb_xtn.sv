`ifndef APB_XTN_SV
`define APB_XTN_SV

class apb_xtn extends uvm_sequence_item;
  `uvm_object_utils(apb_xtn)
  
 rand logic pwrite;
 rand logic[15:0] paddr;
 rand logic[31:0] pwdata;
  logic psel;
  logic penable;
  logic pready;
  logic pslverr;
  logic [31:0]prdata;
  
 // constraint vld_reg_addr {paddr inside {16'h0000};}
 // constraint vld_data {pwdata inside {32'h00000201};}
//  constraint wr_direction{pwrite dist { 1 := 1, 0 := 1 };}
  
  function new(string name = "apb_xtn");
    super.new(name);
  endfunction
  
  function void do_print(uvm_printer printer);
    printer.print_field("PWRITE",this.pwrite,1,UVM_BIN);
    printer.print_field("PADDR",this.paddr,16,UVM_HEX);
    printer.print_field("PWDATA",this.pwdata,32,UVM_HEX);
    printer.print_field("PSEL",this.psel,1,UVM_BIN);
    printer.print_field("PENABLE",this.penable,1,UVM_BIN);
    printer.print_field("PREADY",this.pready,1,UVM_BIN);
    printer.print_field("PSLVERR",this.pslverr,1,UVM_BIN);
    printer.print_field("PRDATA", this.prdata,32,UVM_HEX);
  endfunction
  
endclass

`endif