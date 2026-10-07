`ifndef APB_DRIVER_SV
`define APB_DRIVER_SV

class apb_driver extends uvm_driver#(apb_xtn);
  `uvm_component_utils(apb_driver)
  
  virtual apb_if.APB_DRV_MP apb_vif;
  apb_agent_config apb_agt_cfg;
  
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_agt_cfg))
      `uvm_fatal(get_type_name(),"GETTING AGENT CONFIG FAILED IN DRIVER")
  endfunction
      
  function void connect_phase(uvm_phase phase);
    apb_vif = apb_agt_cfg.vapb_if;
  endfunction
  
  task run_phase(uvm_phase phase);
    
    apb_vif.apb_drv_cb.psel  <= 1'b0;
    apb_vif.apb_drv_cb.penable <= 1'b0;
    apb_vif.apb_drv_cb.pwrite <= 1'b0;
    apb_vif.apb_drv_cb.paddr <= 16'd0;
    apb_vif.apb_drv_cb.pwdata <= 32'd0;
    
    forever
      begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
  endtask
  
  task send_to_dut(apb_xtn req);
     
    `uvm_info("APB_DRIVER",$sformatf("printing from APB_DRIVER %s",req.sprint()),UVM_HIGH)
    
    wait(apb_vif.preset_n == 1);
    
    //setup phase 
    @(apb_vif.apb_drv_cb);
    apb_vif.apb_drv_cb.psel  <= 1'b1;
    apb_vif.apb_drv_cb.penable <= 1'b0;
    
    apb_vif.apb_drv_cb.pwrite <= req.pwrite;
    apb_vif.apb_drv_cb.paddr <= req.paddr;
    apb_vif.apb_drv_cb.pwdata <= req.pwdata;
    
    //access phase
    @(apb_vif.apb_drv_cb);
    apb_vif.apb_drv_cb.penable <= 1'b1;
    
    //wait states
    while(!apb_vif.apb_drv_cb.pready)
      @(apb_vif.apb_drv_cb);
    
    //end transfer
    apb_vif.apb_drv_cb.psel  <= 1'b0;
    apb_vif.apb_drv_cb.penable <= 1'b0;

  endtask
  
endclass

`endif