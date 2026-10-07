`ifndef MD_IF_SV
`define MD_IF_SV

interface md_if#(int unsigned DATA_WIDTH = 32) (input clk);
  
  localparam OFFSET_WIDTH = $clog2(DATA_WIDTH/8) < 1 ? 1 : $clog2(DATA_WIDTH/8);
  
  localparam SIZE_WIDTH = $clog2(DATA_WIDTH/8)+1;
  
  logic reset_n;
  logic valid;
  logic [DATA_WIDTH-1 : 0] data;
  logic [OFFSET_WIDTH-1 : 0] offset;
  logic [SIZE_WIDTH-1 : 0] size;
  logic ready;
  logic err;
 
endinterface

`endif