`ifndef ALGN_TEST_MULTIPLE_INTERRUPTS_SV
`define ALGN_TEST_MULTIPLE_INTERRUPTS_SV

class algn_test_multiple_interrupts extends algn_test_base;
  `uvm_component_utils(algn_test_multiple_interrupts)
  
  multiple_interrupts_vseq 		vseqh;
  
  function new(string name = "algn_test_multiple_interrupts",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    vseqh = multiple_interrupts_vseq :: type_id :: create("vseqh");
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseqh.start(envh.algn_vseqrh);
    #100ns;
    phase.drop_objection(this);
  endtask
  
endclass

`endif