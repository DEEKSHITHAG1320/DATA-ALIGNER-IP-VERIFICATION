`ifndef MD_RX_DRIVER_SV
`define MD_RX_DRIVER_SV

class md_rx_driver extends uvm_driver#(md_rx_xtn);
  `uvm_component_utils(md_rx_driver)
  
  virtual md_if#(DATA_WIDTH) md_vif;
  md_rx_agent_config#(DATA_WIDTH) rx_agt_cfg;
  
  function new(string name = "md_rx_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(md_rx_agent_config#(DATA_WIDTH))::get(this, "", "md_rx_agent_config", rx_agt_cfg))
      `uvm_fatal(get_type_name(), "GETTING MD_RX_AGENT_CONFIG FAILED IN DRIVER")
  endfunction

  function void connect_phase(uvm_phase phase);
    md_vif = rx_agt_cfg.md_vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
  endtask
    
  task send_to_dut(md_rx_xtn req);
    `uvm_info("MD_RX_DRIVER",$sformatf("printing from MD_RX_DRIVER %s",req.sprint()),UVM_HIGH)
    
    md_vif.valid <= 0;
    
    wait(md_vif.reset_n == 1);
    @(posedge md_vif.clk);
    
    md_vif.valid <= 1;
    md_vif.data <= req.data;
    md_vif.offset <= req.offset;
    md_vif.size <= req.size;
    
    wait(md_vif.ready == 1);
	@(posedge md_vif.clk);
	md_vif.valid <= 0;
    
  endtask
    
endclass

`endif