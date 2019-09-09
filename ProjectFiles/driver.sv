
class mips32r1_driver extends uvm_driver #(mips32r1_seq_item);
  
    `uvm_component_utils(mips32r1_driver)

    virtual mips32r1_if vi;
    mips32r1_seq_item req;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      if( !uvm_config_db #(virtual mips32r1_if)::get(this, "", "trans", vi) )
        `uvm_error("", "uvm_config_db::get failed")
        req = mips32r1_seq_item::type_id::create("req",this);
    endfunction 
   
        
    task run_phase(uvm_phase phase);
      forever begin
        seq_item_port.get_next_item(req);
 		drive(req);
        seq_item_port.item_done();
      end
    endtask
      
      
      task drive(input mips32r1_seq_item req);
        @(posedge vi.DRIVER.clk);
        @(vi.pc);        
        req.reset = vi.reset;
        req.pc = vi.pc;
        vi.instr = req.instr;
      endtask    
  
  endclass: mips32r1_driver