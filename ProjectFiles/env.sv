
class mips32r1_env extends uvm_env;

  `uvm_component_utils(mips32r1_env)
    
  	mips32r1_agent      agent;
  	mips32r1_coverage	  cov;
  	mips32r1_scoreboard sc;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
 
    function void build_phase(uvm_phase phase);
      agent = mips32r1_agent::type_id::create("agent", this);      
      cov = mips32r1_coverage::type_id::create("cov", this);    
      sc = mips32r1_scoreboard::type_id::create("sc", this);
    endfunction: build_phase
  	
  function void connect_phase(uvm_phase phase);
    agent.monitor.m_port.connect(cov.sb_port);
    agent.monitor.m_port.connect(sc.sc_port);
  endfunction: connect_phase
  
endclass: mips32r1_env