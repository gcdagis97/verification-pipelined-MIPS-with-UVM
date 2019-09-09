

class mips32r1_agent extends uvm_agent;

    `uvm_component_utils(riscv_agent)
    
    mips32r1_sequencer seqr;
    mips32r1_driver    driver;
  	mips32r1_monitor	 monitor;
  	    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
 
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      	monitor = mips32r1_monitor::type_id::create("monitor", this);
      seqr = mips32r1_sequencer::type_id::create("seqr", this); 
      driver = mips32r1_driver::type_id::create("driver", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      driver.seq_item_port.connect( seqr.seq_item_export );
      
    endfunction: connect_phase
    
  endclass: mips32r1_agent
    