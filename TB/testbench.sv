// Code your testbench here
// or browse Examples

`include "apb_if.sv"
`include "md_if.sv"
`include "algn_test_pkg.sv"


module testbench();
  
  localparam ALGN_DATA_WIDTH = 32;
  
  import uvm_pkg::*;
  import algn_test_pkg::*;
  
  reg clk = 1'b0;
  reg reset_n;
  logic irq;
  
  always #5 clk = ~clk;
  
  initial begin
    reset_n = 0;
    #10ns;
    reset_n = 1;
  end
  
  assign md_rx_if.reset_n = reset_n;
  assign md_tx_if.reset_n = reset_n;
  
  apb_if APB_INF(.pclk(clk), .preset_n(reset_n));
  
  md_if#(ALGN_DATA_WIDTH) md_rx_if(.clk(clk));
  md_if#(ALGN_DATA_WIDTH) md_tx_if(.clk(clk));

  aligner DUT(.clk(clk), 
                  .reset_n(reset_n), 
                  
                  .paddr(APB_INF.paddr), 
                  .pwrite(APB_INF.pwrite),
                  .psel(APB_INF.psel), 
                  .penable(APB_INF.penable), 
                  .pwdata(APB_INF.pwdata), 
                  .pready(APB_INF.pready), 
                  .prdata(APB_INF.prdata), 
                  .pslverr(APB_INF.pslverr), 
                  
                  .md_rx_valid(md_rx_if.valid),
                  .md_rx_data(md_rx_if.data), 
                  .md_rx_offset(md_rx_if.offset), 
                  .md_rx_size(md_rx_if.size), 
                  .md_rx_ready(md_rx_if.ready),
                  .md_rx_err(md_rx_if.err),
                  
                  .md_tx_valid(md_tx_if.valid),
                  .md_tx_data(md_tx_if.data), 
                  .md_tx_offset(md_tx_if.offset), 
                  .md_tx_size(md_tx_if.size),
                  .md_tx_ready(md_tx_if.ready),
              	  .md_tx_err(md_tx_if.err),
                  .irq(irq)
                 );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    uvm_config_db#(virtual apb_if) :: set(null, "*", "apb_if", APB_INF);
    
    uvm_config_db#(virtual md_if#(ALGN_DATA_WIDTH)) :: set(null, "*", "md_rx_if", md_rx_if);
    uvm_config_db#(virtual md_if#(ALGN_DATA_WIDTH)) :: set(null, "*", "md_tx_if", md_tx_if);
    
    run_test();
  end
  
  
endmodule
