
class mips32r1_test extends uvm_test;
  
  `uvm_component_utils(mips32r1_test)
    
    mips32r1_env env;
    mips32r1_sequence sequ;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      env = mips32r1_env::type_id::create("env", this);
      sequ = mips32r1_sequence::type_id::create("sequ");
    endfunction
    
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      sequ.start(env.agent.seqr);
      phase.drop_objection(this);
      $display("\nCOVERAGE :	%d",env.cov.instructions.c_cross.get_coverage());
    endtask
      
  endclass: mips32r1_test
  