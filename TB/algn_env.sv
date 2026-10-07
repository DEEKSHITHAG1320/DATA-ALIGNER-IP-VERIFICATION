`ifndef ALGN_ENV_SV
`define ALGN_ENV_SV

class algn_env extends uvm_env;
  
  `uvm_component_utils(algn_env)
  
  apb_agent apb_agth;

  
  md_rx_agent#(DATA_WIDTH) rx_agth;
  md_tx_agent#(DATA_WIDTH) tx_agth;
  
  algn_virtual_sequencer algn_vseqrh;
  
  function new(string name = "algn_name", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    apb_agth = apb_agent :: type_id :: create("apb_agth",this);
    
    rx_agth = md_rx_agent#(DATA_WIDTH) :: type_id :: create("rx_agth",this);
    tx_agth = md_tx_agent#(DATA_WIDTH) :: type_id :: create("tx_agth",this);
    
    algn_vseqrh = algn_virtual_sequencer :: type_id :: create("algn_vseqrh",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    algn_vseqrh.apb_seqrh = apb_agth.p_seqrh ;
    algn_vseqrh.md_rx_seqrh = rx_agth.rx_seqrh ;
    algn_vseqrh.md_tx_seqrh = tx_agth.tx_seqrh ;
  endfunction
endclass

`endif
