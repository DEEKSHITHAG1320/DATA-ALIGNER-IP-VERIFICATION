`ifndef CLR_WRITE1_VSEQ_SV
`define CLR_WRITE1_VSEQ_SV

class clr_write1_vseq extends algn_virtual_base_sequence;
  `uvm_object_utils(clr_write1_vseq)
  
  md_rx_illegal_pkt_seq  rx_illegal_seqh;
  ctrl_clr_one_seq       clr_one_seqh;
  
  function new(string name = "clr_write1_vseq");
    super.new(name);
  endfunction
  
  task body();
    
    // Generate 50 illegal packets
    repeat(50)
      begin
        rx_illegal_seqh = md_rx_illegal_pkt_seq :: type_id :: create("rx_illegal_seqh");
        
        rx_illegal_seqh.start(v_seqrh.md_rx_seqrh);
      end
    
    // Write CLR=1
    clr_one_seqh = ctrl_clr_one_seq :: type_id :: create("clr_one_seqh");
    clr_one_seqh.start(v_seqrh.apb_seqrh);
    
    // Generate 51 illegal packets
    rx_illegal_seqh = md_rx_illegal_pkt_seq :: type_id :: create("rx_illegal_seqh");
    rx_illegal_seqh.start(v_seqrh.md_rx_seqrh);
  endtask
  
endclass

`endif