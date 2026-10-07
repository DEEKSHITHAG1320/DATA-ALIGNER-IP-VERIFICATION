`ifndef APB_IF_SV
`define APB_IF_SV

`ifndef APB_DATA_WIDTH 
`define APB_DATA_WIDTH 32
`endif

`ifndef APB_ADDR_WIDTH
`define APB_ADDR_WIDTH 16
`endif

interface apb_if(input pclk,input preset_n);
  
  logic [`APB_ADDR_WIDTH-1:0] paddr;
  logic pwrite;
  logic psel;
  logic penable;
  logic [`APB_DATA_WIDTH-1:0] pwdata;
  logic pready;
  logic [`APB_DATA_WIDTH-1:0] prdata;
  logic pslverr;
  
  clocking apb_drv_cb@(posedge pclk);
    output paddr,pwrite,psel,penable,pwdata;
    input pready;
  endclocking
  
  modport APB_DRV_MP(clocking apb_drv_cb,input preset_n);
    
    clocking apb_mon_cb@(posedge pclk);
      input paddr,pwrite,psel,penable,pwdata,pready,prdata,pslverr;
    endclocking
    
    modport APB_MON_MP(clocking apb_mon_cb,input preset_n);

//ASSERTIONS      
//PENABLE should be low in setup phase  
property apb_setup_p;
  @(posedge pclk)disable iff(!preset_n)
  $rose(psel) |-> !penable;
endproperty
      
      PENABLE_AT_SETUP_PHASE_A : assert property(apb_setup_p) else
        $error("PENABLE at setup_phase is not equal to 0");
      
//PENABLE should be asserted in the access phase  
property penable_assert_second_cycle_p;
  @(posedge pclk) disable iff(!preset_n)
  $rose(psel) |=> penable;
endproperty       
        
        PENABLE_ASSERT_SECOND_CYCLE_A : assert property(penable_assert_second_cycle_p)else
          $error("PENABLE not asserted in second cycle"); 

//PENABLE must be deasserted at end of transfer
property penable_deasserted_at_end_transfer_p;
  @(posedge pclk) disable iff(!preset_n)
  (psel && penable && pready) |=> !penable;
endproperty 
       
      PENABLE_DEASSERTED_AT_END_TRANSFER_A : assert property(penable_deasserted_at_end_transfer_p) else
      	$error("PENABLE not deasserted even transfer has been completed");
         
//master signals must remain constant throughout the transfer
property master_signals_stable_p;
  @(posedge pclk) disable iff(!preset_n)
  (psel && penable && !pready) |-> $stable({paddr,pwrite,pwdata});
endproperty
        
        MASTER_SIGNALS_STABLE_A : assert property(master_signals_stable_p) else
          $error("MASTER signals are not stable throughout the transfer");
      
//APB signals can not have unkown values(e.g x,z)
property unkown_values_p;
  @(posedge pclk) disable iff(!preset_n)
  $rose(preset_n) |=> !$isunknown({pready,pslverr,prdata});
endproperty
          
          UNKOWN_VALUES_A : assert property(unkown_values_p) else
            $error("UNKOWN values for apb signals");
        
endinterface

`endif