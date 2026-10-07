`ifndef MD_RX_AGENT_CONFIG_SV
`define MD_RX_AGENT_CONFIG_SV

class md_rx_agent_config#(int unsigned DATA_WIDTH = 32) extends uvm_sequence_item;
  `uvm_object_param_utils(md_rx_agent_config#(DATA_WIDTH))
  
  virtual md_if#(DATA_WIDTH) md_vif;
  	uvm_active_passive_enum is_active;
 	bit has_coverage = 1'b1;
  
  function new(string name = "md_rx_agent_config");
    super.new(name);
  endfunction
  
endclass

`endif