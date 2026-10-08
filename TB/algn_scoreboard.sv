`ifndef ALGN_SCOREBOARD_SV
`define ALGN_SCOREBOARD_SV

class algn_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(algn_scoreboard)
  
  uvm_tlm_analysis_fifo #(apb_xtn)   apb_fifo;
  uvm_tlm_analysis_fifo #(md_rx_xtn) rx_fifo;
  uvm_tlm_analysis_fifo #(md_tx_xtn) tx_fifo;
  
  bit[2:0] ctrl_size;
  bit[1:0] ctrl_offset;
      
  int pass_count;
  int fail_count;

      function new(string name = "algn_scoreboard",uvm_component parent);
        super.new(name,parent);
      endfunction
      
      function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        apb_fifo = new("apb_fifo",this);
        rx_fifo = new("rx_fifo",this);
        tx_fifo = new("tx_fifo",this);
        
        ctrl_size = 1;
        ctrl_offset = 0;
      endfunction
      
      //REFERENCE MODEL 
      function bit[31:0] predict_data
        (
        bit [31:0] rx_data,
        bit [2:0] rx_size,
        bit [1:0] rx_offset,
        bit [1:0] ctrl_offset
        );
        
        bit [31:0] extracted_data;
        bit [31:0] aligned_data;
        bit [31:0] mask;
        
        case(rx_size)
          1 : mask = 32'h000000FF;
          2 : mask = 32'h0000FFFF;
          4 : mask = 32'hFFFFFFFF;
          default : mask = 32'h00000000;
        endcase
        
        extracted_data = (rx_data >> (rx_offset * 8)) & mask;
        
        aligned_data = extracted_data << (ctrl_offset * 8);
        
       return aligned_data;
      endfunction
      
      //track ctrl register track 
      task track_ctrl();
        apb_xtn apb_h;
        forever
          begin
            apb_fifo.get(apb_h);
            if(apb_h.pwrite && apb_h.paddr==16'h0000)
              begin
                ctrl_size = apb_h.pwdata[2:0];
                ctrl_offset = apb_h.pwdata[9:8];
              end
          end
      endtask
      
      //compare RX and TX 
      task compare();
        md_rx_xtn rx_h;
        md_tx_xtn tx_h;
        
        bit[31:0] exp_data;
        
        forever 
          begin
            rx_fifo.get(rx_h);
            tx_fifo.get(tx_h);
            
            `uvm_info("SB",$sformatf("RX=%h TX=%h TIME=%0t",rx_h.data,tx_h.data,$time),UVM_NONE)
            
            exp_data = predict_data(rx_h.data,
                                    rx_h.size,
                                    rx_h.offset,
                                    ctrl_offset);
            
            if(exp_data == tx_h.data && ctrl_size == tx_h.size && ctrl_offset == tx_h.offset)
              begin
                pass_count++;
              end
            else
              begin
                fail_count++;
                `uvm_error("ALIGNER_SB",$sformatf("EXP_DATA = %h, ACT_DATA = %h",exp_data,tx_h.data))
              end
          end
      endtask
      
      task run_phase(uvm_phase phase);
        fork
          track_ctrl();
          compare();
        join_none
      endtask
      
      function void report_phase(uvm_phase phase);
        `uvm_info("ALIGNER_SB", $sformatf("\nPASS = %0d FAIL = %0d",pass_count,fail_count),UVM_NONE)
      endfunction
      
endclass
      
`endif