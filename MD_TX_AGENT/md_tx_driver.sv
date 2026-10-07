`ifndef MD_TX_DRIVER_SV
`define MD_TX_DRIVER_SV

class md_tx_driver extends uvm_driver#(md_tx_xtn);
  `uvm_component_utils(md_tx_driver)
  
  virtual md_if#(DATA_WIDTH) md_vif;
  md_tx_agent_config#(DATA_WIDTH) tx_agt_cfg;
  
  function new(string name = "md_tx_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(md_tx_agent_config#(DATA_WIDTH))::get(this, "", "md_tx_agent_config", tx_agt_cfg))
      `uvm_fatal(get_type_name(), "GETTING MD_TX_AGENT_CONFIG FAILED IN DRIVER")
  endfunction
   
   function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology;
  endfunction
  
  function void connect_phase(uvm_phase phase);
    md_vif = tx_agt_cfg.md_vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
  endtask
  
  task send_to_dut(md_tx_xtn req);
    
    `uvm_info("MD_TX_DRIVER",$sformatf("printing from MD_TX_DRIVER %s",req.sprint()),UVM_HIGH)
    
    md_vif.ready <= 0;
    md_vif.err <= 0;
    
    wait(md_vif.reset_n == 1);
    @(md_vif.clk);
    md_vif.ready <= req.ready;
      
    
  endtask
  
endclass

`endif