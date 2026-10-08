`ifndef ALGN_COVERAGE_SV
`define ALGN_COVERAGE_SV

class algn_coverage extends uvm_subscriber #(md_rx_xtn);
  `uvm_component_utils(algn_coverage)
  
  md_rx_xtn xtn;
  
  bit[2:0]rx_size;
  bit[1:0]rx_offset;
  
  bit legal_pkt;
  
  //coverage
  covergroup aligner_cg;
    cp_rx_size : coverpoint rx_size
    {
      bins size1 = {1};
      bins size2 = {2};
      bins size4 = {4};
    }
    
    cp_rx_offset : coverpoint rx_offset
    {
      bins off0 = {0};
      bins off1 = {1};
      bins off2 = {2};
      bins off3 = {3};
    }
    
    cp_legal : coverpoint legal_pkt
    {
      bins legal = {1};
      bins illegal = {0};
    }
    
    cross cp_rx_size, cp_rx_offset;
  endgroup
  
  function new(string name = "algn_coverage", uvm_component parent);
    super.new(name,parent);
    
    aligner_cg = new();
    
  endfunction
  
  function void write(md_rx_xtn t);
    rx_size = t.size;
    rx_offset = t.offset;
    
    legal_pkt = (((4+rx_offset)%rx_size)==0);
    
    aligner_cg.sample();
  endfunction
  
  function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE",$sformatf("Functional Coverage = %0.2f%%",aligner_cg.get_coverage()),UVM_NONE)
  endfunction
  
endclass

`endif