
class mips32r1_monitor extends uvm_monitor;
  
  `uvm_component_utils(riscv_monitor)
  
  uvm_analysis_port #(riscv_seq_item) m_port;
  
  
  mips32r1_seq_item seq;
  virtual mips32r1_if inf;  //create virtual interface
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
    m_port = new("m_port",this);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual mips32r1_if)::get(this,"","trans",inf))
      `uvm_error("", "uvm_config_db::get failed") 
  endfunction: build_phase
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq = mips32r1_seq_item::type_id::create("seq") ;
      @ (posedge inf.MONITOR.clk ); 
      seq.pc = inf.pc;
      seq.instr = inf.instr;    
      seq.reset = inf.reset;

      m_port.write(seq);
    end
  endtask : run_phase
endclass : mips32r1_monitor
    