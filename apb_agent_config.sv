`ifndef APB_AGENT_CONFIG_SV
`define APB_AGENT_CONFIG_SV

class apb_agent_config extends uvm_sequence_item;
  `uvm_object_utils(apb_agent_config)
  
  virtual apb_if vapb_if;
  uvm_active_passive_enum is_active;
  bit has_coverage = 1'b1;
  
  function new(string name = "apb_agent_config");
    super.new(name);
  endfunction
  
endclass

`endif
