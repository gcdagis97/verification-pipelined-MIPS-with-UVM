      
class mips32r1_sequencer extends uvm_sequencer #(mips32r1_seq_item);
    
  	`uvm_component_utils(mips32r1_sequencer)
        
	function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  
endclass: mips32r1_sequencer
