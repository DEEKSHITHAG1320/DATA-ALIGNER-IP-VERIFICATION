`ifndef APB_COVERAGE_SV
`define APB_COVERAGE_SV

class apb_coverage extends uvm_component;
  `uvm_component_utils(apb_coverage)
  
  uvm_analysis_imp#(apb_xtn,apb_coverage)analysis_export;
  apb_xtn trans;
  
  real total_cov;
  
  covergroup addr_cg;
    cp_addr : coverpoint trans.paddr
    {
      bins CTRL_REG = {16'h0000};
      bins STATUS_REG = {16'h000C};
      bins IRQEN_REG = {16'h00F0};
      bins IRQ_REG = {16'h00F4};
    }
  endgroup
  
  covergroup direction_cg;  
    cp_rw : coverpoint trans.pwrite
    {
      bins READ = {0};
      bins WRITE = {1};
    }
  endgroup
    
  covergroup error_cg;
    cp_error : coverpoint trans.pslverr
    {
      bins OKAY_RESPONSE = {0};
      bins ERROR_RESPONSE = {1};
    }
  endgroup
    
  covergroup ready_cg;
    cp_ready : coverpoint trans.pready
    {
      bins READY = {1};
    }
  endgroup
  
  
  function new(string name = "apb_coverage",uvm_component parent);
    super.new(name,parent);
    analysis_export = new("analysis_export",this);
    trans = new();
    
    addr_cg = new();
    direction_cg = new();
    error_cg =new();
    ready_cg = new();
  endfunction
  
  virtual function void write(apb_xtn xtn);
    trans = xtn;
    addr_cg.sample();
    direction_cg.sample();
    error_cg.sample();
    ready_cg.sample();
    
    total_cov = ( addr_cg.get_coverage()+ direction_cg.get_coverage()+ error_cg.get_coverage()+ ready_cg.get_coverage() ) / 4.0;
    
    `uvm_info("APB_COVERAGE",$sformatf("\nADDR = %0.2f%%\nDIR = %0.2f%%\nERR = %0.2f%%\nREADY = %0.2f%%\nTOTAL = %0.2f%%", addr_cg.get_coverage(),direction_cg.get_coverage(),error_cg.get_coverage(),ready_cg.get_coverage(),total_cov),UVM_LOW)
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
   `uvm_info("APB_COVERAGE",$sformatf("\nADDR = %0.2f%%\nDIR = %0.2f%%\nERR = %0.2f%%\nREADY = %0.2f%%\nTOTAL = %0.2f%%", addr_cg.get_coverage(),direction_cg.get_coverage(),error_cg.get_coverage(),ready_cg.get_coverage(),total_cov),UVM_LOW)
  endfunction
  
endclass

`endif