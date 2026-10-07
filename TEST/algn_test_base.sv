`ifndef ALGN_TEST_BASE_SV
  `define ALGN_TEST_BASE_SV

class algn_test_base extends uvm_test;
  
  `uvm_component_utils(algn_test_base)
  
  algn_env envh;
  
  apb_agent_config apb_agt_cfg;
  
  md_rx_agent_config#(DATA_WIDTH) rx_agt_cfg;
  md_tx_agent_config#(DATA_WIDTH) tx_agt_cfg;
  
  
  function new(string name = "algn_test_base",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    apb_agt_cfg = apb_agent_config :: type_id :: create("apb_agt_cfg");
    
    rx_agt_cfg = md_rx_agent_config#(DATA_WIDTH) :: type_id :: create("md_rx_agent_config");
    tx_agt_cfg = md_tx_agent_config#(DATA_WIDTH) :: type_id :: create("md_tx_agent_config");
    
    apb_agt_cfg.is_active = UVM_ACTIVE;
    if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_agt_cfg.vapb_if))
      `uvm_fatal(get_type_name(),"GETTING VIRTUAL APB_IF FAILED IN TEST")
      uvm_config_db#(apb_agent_config)::set(this,"envh.apb_agth*","apb_agent_config",apb_agt_cfg);
    
    rx_agt_cfg.is_active = UVM_ACTIVE;
    if(!uvm_config_db#(virtual md_if#(32)) :: get(this, "", "md_rx_if", rx_agt_cfg.md_vif))
      `uvm_fatal(get_type_name(),"GETTING VIRTUAL MD_IF FAILED IN TEST")
      uvm_config_db#(md_rx_agent_config#(32))::set(this,"envh.rx_agth*","md_rx_agent_config",rx_agt_cfg);
    
    tx_agt_cfg.is_active = UVM_ACTIVE;
    if(!uvm_config_db#(virtual md_if#(32)) :: get(this, "", "md_tx_if", tx_agt_cfg.md_vif))
      `uvm_fatal(get_type_name(),"GETTING VIRTUAL MD_IF FAILED IN TEST")
      uvm_config_db#(md_tx_agent_config#(32))::set(this,"envh.tx_agth*","md_tx_agent_config",tx_agt_cfg);
    
    envh = algn_env :: type_id :: create("envh",this);
  
  endfunction
  
endclass

`endif