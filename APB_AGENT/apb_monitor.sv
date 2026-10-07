`ifndef APB_MONITOR_SV
`define APB_MONITOR_SV

class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  
  virtual apb_if.APB_MON_MP apb_vif;
  apb_agent_config apb_agt_cfg;
  apb_xtn xtn;
  
  uvm_analysis_port#(apb_xtn)analysis_port;
  
  function new(string name = "apb_monitor",uvm_component parent);
    super.new(name,parent);
    analysis_port = new("analysis_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_agt_cfg))
      `uvm_fatal(get_type_name(),"GETTING AGENT CONFIG FAILED IN MONITOR")
    
  endfunction
      
  function void connect_phase(uvm_phase phase);
    	apb_vif = apb_agt_cfg.vapb_if;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        collect_data();
        analysis_port.write(xtn);
      end
  endtask
  
  task collect_data();
      xtn = apb_xtn :: type_id :: create("xtn");
    wait(apb_vif.preset_n == 1);
    
    //wait for setup phase
    wait(apb_vif.apb_mon_cb.psel && !apb_vif.apb_mon_cb.penable);
    
    //sample inputs 
    xtn.paddr = apb_vif.apb_mon_cb.paddr;
    xtn.pwrite = apb_vif.apb_mon_cb.pwrite;
    xtn.pwdata = apb_vif.apb_mon_cb.pwdata;
    
    //wait for transfer to complete
    wait(apb_vif.apb_mon_cb.psel && apb_vif.apb_mon_cb.penable && apb_vif.apb_mon_cb.pready);
    
    //sample outputs
    xtn.pready = apb_vif.apb_mon_cb.pready;
    xtn.pslverr = apb_vif.apb_mon_cb.pslverr;
    xtn.prdata = apb_vif.apb_mon_cb.prdata;
    
    @(apb_vif.apb_mon_cb);
    
    `uvm_info ("APB_MONITOR",$sformatf("printing from APB_MONITOR \n %s",xtn.sprint()),UVM_HIGH)
    
  endtask
  

endclass

`endif