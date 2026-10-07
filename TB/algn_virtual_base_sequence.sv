`ifndef ALGN_VIRTUAL_BASE_SEQUENCE_SV
`define ALGN_VIRTUAL_BASE_SEQUENCE_SV

class algn_virtual_base_sequence extends uvm_sequence;
  `uvm_object_utils(algn_virtual_base_sequence)
  
  algn_virtual_sequencer v_seqrh;
  
  function new(string name = "algn_virtual_base_sequence");
    super.new(name);
  endfunction
  
  task pre_body();
    if(!$cast(v_seqrh,m_sequencer))
      `uvm_fatal(get_type_name(),"Virtual Sequencer Cast Failed")
  endtask
      
endclass

`endif