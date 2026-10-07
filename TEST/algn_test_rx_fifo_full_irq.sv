`ifndef ALGN_TEST_RX_FIFO_FULL_IRQ_SV
`define ALGN_TEST_RX_FIFO_FULL_IRQ_SV

class algn_test_rx_fifo_full_irq extends algn_test_base;
  `uvm_component_utils(algn_test_rx_fifo_full_irq)
  
  rx_fifo_full_irq_vseq		v_seqh;
  
  function new(string name = "algn_test_rx_fifo_full_irq",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    v_seqh = rx_fifo_full_irq_vseq :: type_id :: create("v_seqh");
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    v_seqh.start(envh.algn_vseqrh);
    #100ns;
    phase.drop_objection(this);
  endtask
  
endclass

`endif