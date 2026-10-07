`ifndef ALGN_TEST_TX_RX_LVL_SV
`define ALGN_TEST_TX_RX_LVL_SV

class algn_test_tx_rx_lvl extends algn_test_base;
  `uvm_component_utils(algn_test_tx_rx_lvl)
  
  tx_rx_lvl_vseq 	vseqh;
  
  function new(string name = "algn_test_tx_rx_lvl", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    vseqh = tx_rx_lvl_vseq :: type_id :: create("vseqh");
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseqh.start(envh.algn_vseqrh);
    #100ns;
    phase.drop_objection(this);
  endtask
  
endclass

`endif