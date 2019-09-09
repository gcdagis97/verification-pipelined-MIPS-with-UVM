//import uvm_pkg::*;

class mips32r1_seq_item extends (mips32r1_seq_item);
  
    `uvm_object_utils(mips32r1_seq_item)
  
  rand logic [31:0]pc; 
  rand logic [31:0]instr;
  string instr_name;
  reg reset;
  
  function new (string name = "mips32r1_seq_item");
      super.new(name);
    endfunction
  
  
  

  constraint c_opcode{ instr[5:0] inside {6'b110111,6'b010111,6'b101111,6'b100111,6'b100011,6'b000011,6'b100011,6'b010011,6'b110011,6'b001111,6'b110011}; 
                     }
  constraint c_funct{
    (instr[10:0] == 11'b00000001001) -> (instr[31:26] inside {6'b000000}); 	//	JALR
    (instr[10:6] == 5'b00000) -> (instr[5:0] inside {6'b101011:6'b000000}); 	//R

  }
  
  
      function string convert2string;
        case(instr[31:26])
          6'd8  : instr_name = "ADDI";
          6'd9  : instr_name = "ADDIU";
          6'd10 : instr_name = "SLTI";
          6'd11 : instr_name = "SLTIU";
          6'd12 : instr_name = "ANDI";
          6'd13 : instr_name = "ORI";
          6'd14 : instr_name = "XORI";
          6'd32 : instr_name = "LB";
          6'd33 : instr_name = "LH";
          6'd34 : instr_name = "LWL";
          6'd35 : instr_name = "LW";
          6'd36 : instr_name = "LBU";
          6'd37 : instr_name = "LHU";
          6'd38 : instr_name = "LWR";
          6'd40 : instr_name = "SB";
          6'd41 : instr_name = "SH";
          6'd42 : instr_name = "SWL";
          6'd43 : instr_name = "SW";
          6'd46 : instr_name = "SWR";
          6'd15 : instr_name = "LUI";
          6'b0: instr_name = "JALR";
          6'd1: 
            case(instr[20:16])
              5'd0 : instr_name = "BLTZ";
              5'd1 : instr_name = "BGEZ";
              5'd16 : instr_name = "BLTZAL";
              5'd17 : instr_name = "BGEZAL";
            endcase
        endcase
        return $psprintf("PC = %h,  INSTRUCTION = %h,  INSTRUCTION TYPE = %s, rd = %d", pc,  instr, instr_name, instr[15:11]);
    endfunction: convert2string
     
endclass: mips32r1_seq_item

    