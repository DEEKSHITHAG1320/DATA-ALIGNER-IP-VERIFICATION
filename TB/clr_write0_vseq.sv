`ifndef CLR_WRITE0_VSEQ_SV
`define CLR_WRITE0_VSEQ_SV

class clr_write0_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(clr_write0_vseq)
  
  irqen_maxdrop_enable_seq 		irqen_maxdrop_seqh;
  md_rx_illegal_pkt_seq  		rx_illegal_seqh;
  ctrl_clr_zero_seq 			clr_zero_seqh;
  
  function new(string name = "clr_write0_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    // enable MAX_DROP interrupt
    irqen_maxdrop_seqh = irqen_maxdrop_enable_seq :: type_id :: create("irqen_maxdrop_seqh");
    irqen_maxdrop_seqh.start(v_seqrh.apb_seqrh);
    
    // send 254 illegal packets
    repeat(254)
      begin
        rx_illegal_seqh = md_rx_illegal_pkt_seq :: type_id :: create("rx_illegal_seqh");
        rx_illegal_seqh.start(v_seqrh.md_rx_seqrh);
      end
    
    // write CLR = 0
    clr_zero_seqh = ctrl_clr_zero_seq :: type_id :: create("clr_zero_seqh");
    clr_zero_seqh.start(v_seqrh.apb_seqrh);
    
    // 255th illegal transfer
    rx_illegal_seqh = md_rx_illegal_pkt_seq :: type_id :: create("rx_illegal_seqh");
    rx_illegal_seqh.start(v_seqrh.md_rx_seqrh);
    
    // saturation check
    rx_illegal_seqh = md_rx_illegal_pkt_seq :: type_id :: create("rx_illegal_seqh");
    rx_illegal_seqh.start(v_seqrh.md_rx_seqrh);
    
  endtask
  
endclass

`endif