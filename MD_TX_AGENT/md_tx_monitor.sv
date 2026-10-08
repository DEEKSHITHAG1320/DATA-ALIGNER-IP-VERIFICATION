`ifndef MD_TX_MONITOR_SV
`define MD_TX_MONITOR_SV

class md_tx_monitor extends uvm_monitor;
  `uvm_component_utils(md_tx_monitor)
  
  virtual md_if#(DATA_WIDTH) md_vif;
  md_tx_agent_config#(DATA_WIDTH) tx_agt_cfg;
  md_tx_xtn xtn;
  
  uvm_analysis_port #(md_tx_xtn) analysis_port;
  
  function new(string name = "md_tx_monitor", uvm_component parent);
    super.new(name,parent);
    analysis_port = new("analysis_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(md_tx_agent_config#(DATA_WIDTH))::get(this,"","md_tx_agent_config",tx_agt_cfg))
      `uvm_fatal(get_type_name,"GETTING MD_TX_AGENT_CONFIG FAILED IN MONITOR")
  endfunction
  
      
  function void connect_phase(uvm_phase phase);
    md_vif = tx_agt_cfg.md_vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        collect_data();
        `uvm_info("TX_MON",$sformatf("DATA=%h SIZE=%0d OFFSET=%0d TIME=%0t",xtn.data,xtn.size,xtn.offset,$time),UVM_NONE)
        analysis_port.write(xtn);
      end
  endtask
  
  task collect_data();
    xtn = md_tx_xtn :: type_id :: create("xtn");

    wait(md_vif.reset_n == 1);
    wait(md_vif.valid && md_vif.ready) 
    
    xtn.valid = md_vif.valid;
    xtn.data = md_vif.data;
    xtn.offset = md_vif.offset;
    xtn.size = md_vif.size;
    xtn.ready = md_vif.ready;
    xtn.err = md_vif.err;

    @(posedge md_vif.clk);
    wait(!(md_vif.valid && md_vif.ready));
     
    `uvm_info ("MD_TX_MONITOR",$sformatf("printing from MD_TX_MONITOR \n %s",xtn.sprint()),UVM_HIGH)
    endtask
  
endclass


`endif
