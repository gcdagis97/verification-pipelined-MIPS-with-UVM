class mips32r1_coverage extends uvm_subscriber#(mips32r1_seq_item);
  
  `uvm_component_utils(mips32r1_coverage)

  uvm_analysis_imp #(mips32r1_seq_item, mips32r1_coverage) sb_port;


  	
  	mips32r1_seq_item trans;
  
   covergroup instructions;
     c_instr : coverpoint trans.instr[31:26] {
        bins LUI = {6'd15};
        bins JALR = {6'd0};
        bins RTYPE = {6'd0};
        //bins LOAD = {7'b0000011};
        //bins STORE = {7'b0100011};
        //bins ITYPE = {7'b0010011};
        //bins FENCE = {7'b0001111};
        //bins CSR = {7'b1110011};
        }
     c_funct : coverpoint trans.instr[14:12];
     c_cross : cross c_instr, c_funct;
    endgroup
  
 
     
  	function new(string name, uvm_component parent);
       super.new(name, parent);
      	instructions = new();
       	sb_port = new("sb_port",this);
  	endfunction : new
    
  
  function void write(input mips32r1_seq_item t);
      trans = t;
      instructions.sample();
  	endfunction 
  

endclass: mips32r1_coverage
       