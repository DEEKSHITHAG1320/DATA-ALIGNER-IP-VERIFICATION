`ifndef MD_TX_AGENT_SV
`define MD_TX_AGENT_SV

class md_tx_agent#(int unsigned DATA_WIDTH = 32) extends uvm_agent;
  `uvm_component_param_utils(md_tx_agent#(DATA_WIDTH))
  
  md_tx_agent_config#(DATA_WIDTH) 	tx_agt_cfg;
  
  md_tx_driver  tx_drvh;
  md_tx_monitor tx_monh;
  md_tx_sequencer tx_seqrh;
  
  function new(string name = "md_tx_agent" ,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(md_tx_agent_config#(DATA_WIDTH))::get(this,"","md_tx_agent_config",tx_agt_cfg))
      `uvm_fatal(get_type_name(),"GETTING MD_TX_AGENT_CONFIG FAILED IN AGENT CLASS")
      
    tx_monh = md_tx_monitor :: type_id :: create("tx_monh",this);
    if(tx_agt_cfg.is_active == UVM_ACTIVE)
      begin
        tx_drvh = md_tx_driver :: type_id :: create("tx_drvh",this);
        tx_seqrh = md_tx_sequencer :: type_id :: create("tx_seqrh",this);
      end
  endfunction
  
 function void connect_phase(uvm_phase phase);
 	 if(tx_agt_cfg.is_active == UVM_ACTIVE)
     	tx_drvh.seq_item_port.connect(tx_seqrh.seq_item_export);
 endfunction
  
endclass
                                            
`endif