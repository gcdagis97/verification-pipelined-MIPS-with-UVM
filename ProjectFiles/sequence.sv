
class mips32r1_sequence extends uvm_sequence#(mips32r1_seq_item);

  `uvm_object_utils(mips32r1_sequence)

  mips32r1_seq_item trans;
  reg [4:0] i;
  reg [31:0] count, ins_mem [1023:0]; 


  function new (string name = "mips32r1_sequence");
    super.new(name); $display("made it to sequence");
  endfunction

    i = 0; 		 //	--------------	TEST  ---------------  //
    repeat(32) begin      
        trans = mips32r1_seq_item::type_id::create("trans");
      trans.instr = {6'b0, i, i, i, 5'b0, 6'100000};  //opcode,rs,rt,rd,shamt,func
      	++i;
        start_item(trans);
        finish_item(trans);
    end 
    
    
    repeat (20) begin	// JUMP
        trans = mips32r1_seq_item::type_id::create("trans");
      	trans.randomize with {
          trans.instr[5:0] inside {6'b001000, 6'b001001}; //randomize within Jump instructions
      	};    
        start_item(trans);
        finish_item(trans);
    end

    repeat (20) begin	//	R
        trans = mips32r1_seq_item::type_id::create("trans");
      	trans.randomize with {
          trans.instr[5:0] inside {6'b101011, 6'b000000}; //randomize an R type instruc
      	};  
        start_item(trans);
        finish_item(trans);
    end
 
    repeat (20) begin	//	I
        trans = mips32r1_seq_item::type_id::create("trans");
      	trans.randomize with {
          trans.instr[31:26] inside {6'd32,6'd15}; //randomize I type instruction
      	};
        start_item(trans);
        finish_item(trans);
    end

        endclass: mips32r1_sequence      