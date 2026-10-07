`ifndef ALGN_TEST_STATUS_RO_SV
`define ALGN_TEST_STATUS_RO_SV

class algn_test_status_ro extends algn_test_base;
  `uvm_component_utils(algn_test_status_ro)
  
  status_ro_vseq	vseqh;
  
  function new(string name = "algn_test_status_ro", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    vseqh = status_ro_vseq :: type_id :: create("vseqh");
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseqh.start(envh.algn_vseqrh);
    #100ns;
    phase.drop_objection(this);
  endtask
  
endclass

`endif