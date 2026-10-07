`ifndef MD_RX_MONITOR_SV
`define MD_RX_MONITOR_SV

class md_rx_monitor extends uvm_monitor;
  `uvm_component_utils(md_rx_monitor);
  
  virtual md_if#(DATA_WIDTH) md_vif;
  md_rx_agent_config#(DATA_WIDTH) rx_agt_cfg;
  md_rx_xtn xtn;
  
  function new(string name = "md_rx_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(md_rx_agent_config#(DATA_WIDTH))::get(this, "", "md_rx_agent_config", rx_agt_cfg))
      `uvm_fatal(get_type_name(), "GETTING MD_RX_AGENT_CONFIG FAILED IN MONITOR")
  endfunction
      
  function void connect_phase(uvm_phase phase);
    md_vif = rx_agt_cfg.md_vif;
  endfunction
  
 task run_phase(uvm_phase phase);
  forever
   begin
     collect_data();
   end
  endtask
  
 task collect_data();
   
   xtn = md_rx_xtn :: type_id :: create("xtn");
   
   wait(md_vif.reset_n);
   wait(md_vif.valid && md_vif.ready); 
   
   xtn.valid = md_vif.valid;
   xtn.data = md_vif.data;
   xtn.offset = md_vif.offset;
   xtn.size = md_vif.size;
   xtn.ready = md_vif.ready;
   xtn.err = md_vif.err;
   @(posedge md_vif.clk);
   
   `uvm_info ("MD_RX_MONITOR",$sformatf("printing from MD_RX_MONITOR \n %s",xtn.sprint()),UVM_HIGH)
   
endtask
     

endclass

`endif