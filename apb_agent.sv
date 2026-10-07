`ifndef APB_AGENT_SV
`define APB_AGENT_SV

class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)
  
  apb_agent_config apb_agt_cfg;
  
  apb_driver p_drvh;
  apb_monitor p_monh;
  apb_sequencer p_seqrh;
  apb_coverage apb_cvg;
  
  function new(string name = "apb_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_agt_cfg))
      `uvm_fatal(get_type_name(),"GETTING APB AGENT CONFIG FAILED IN AGENT")
      
      p_monh = apb_monitor :: type_id :: create("p_monh",this);
    apb_cvg = apb_coverage :: type_id :: create("apb_cvg",this);
    if(apb_agt_cfg.is_active == UVM_ACTIVE)
      begin
        p_drvh = apb_driver :: type_id :: create("p_drvh",this);
        p_seqrh = apb_sequencer :: type_id :: create("p_seqrh",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(apb_agt_cfg.is_active == UVM_ACTIVE)
    	p_drvh.seq_item_port.connect(p_seqrh.seq_item_export);
    if(apb_agt_cfg.has_coverage)
      p_monh.analysis_port.connect(apb_cvg.analysis_export);
  endfunction
  
endclass

`endif