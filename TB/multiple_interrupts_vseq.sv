`ifndef MULTIPLE_INTERRUPTS_VSEQ_SV
`define MULTIPLE_INTERRUPTS_VSEQ_SV

class multiple_interrupts_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(multiple_interrupts_vseq)
  
  irqen_all_interrupts_seq		irqen_h;
  md_tx_not_ready_seq			block_h;
  md_tx_ready_seq				release_h;
  md_rx_illegal_pkt_seq			illegal_h;
  md_rx_legal_pkt_seq			legal_h;
  irq_read_seq					rd_h;
  
  function new(string name = "multiple_interrupts_vseq");
    super.new(name);
  endfunction
  
  task body();
    //enable all interrupts 
    irqen_h = irqen_all_interrupts_seq :: type_id :: create("irqen_h");
    irqen_h.start(v_seqrh.apb_seqrh);
    
    //generate MAX DROP 
    repeat(255)
      begin
        illegal_h = md_rx_illegal_pkt_seq :: type_id :: create("illegal_h");
        illegal_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //Block TX
    block_h = md_tx_not_ready_seq :: type_id :: create("block_h");
    block_h.start(v_seqrh.md_tx_seqrh);
    
    //generate TX & RX FIFO FULL
    repeat(8)
      begin
        legal_h = md_rx_legal_pkt_seq :: type_id :: create("legal_h");
        legal_h.start(v_seqrh.md_rx_seqrh);
      end
    
    //release TX
    release_h = md_tx_ready_seq :: type_id :: create("release_h");
    release_h.start(v_seqrh.md_tx_seqrh);
    
    //wait for drain 
    #100ns;
    
    //Read IRQ
    rd_h = irq_read_seq :: type_id :: create("rd_h");
    rd_h.start(v_seqrh.apb_seqrh);
  endtask
  
endclass

`endif