`ifndef MD_RX_AGENT_SV
`define MD_RX_AGENT_SV

class md_rx_agent#(int unsigned DATA_WIDTH = 32) extends uvm_agent;
  `uvm_component_param_utils(md_rx_agent#(DATA_WIDTH))
  
  md_rx_agent_config#(DATA_WIDTH) 	rx_agt_cfg;
  
  md_rx_driver    		rx_drvh;
  md_rx_monitor   		rx_monh;
  md_rx_sequencer 		rx_seqrh;
  
  function new(string name = "md_rx_agent" ,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    if(!uvm_config_db#(md_rx_agent_config#(DATA_WIDTH))::get(this, "", "md_rx_agent_config", rx_agt_cfg))
      `uvm_fatal(get_type_name(), "GETTING MD_RX_AGENT_CONFIG FAILED IN AGENT")
      
      rx_monh = md_rx_monitor :: type_id :: create("rx_monh",this);
    if(rx_agt_cfg.is_active == UVM_ACTIVE)
      begin
        rx_drvh = md_rx_driver :: type_id :: create("rx_drvh",this);
        rx_seqrh = md_rx_sequencer :: type_id :: create("rx_seqrh",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(rx_agt_cfg.is_active == UVM_ACTIVE)
      rx_drvh.seq_item_port.connect(rx_seqrh.seq_item_export);
  endfunction
  
endclass

`endif
