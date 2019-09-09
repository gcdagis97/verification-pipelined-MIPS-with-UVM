//import uvm_pkg::*;
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv" 
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "subscriber.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
`include "uvm_macros.svh"

module top();

  bit clk;
  bit reset; 

  initial begin
   $dumpfile("dump.vcd"); 
   $dumpvars;  	
    clk = 0;
    reset = 0;
    #20 reset = 1;
  end

  always #2 clk = ~clk;
   
 
  mips32r1_if mips32r1_if0 ( 
    .clk(clk),
    .reset(reset)
  );

  //creating interfaces for DUT (TAKEN FROM PROCESSOR)
  mips32r1 DUT(
    .clock(mips32r1_if0.clk),
    .reset(mips32r1_if0.reset),
    .Interrupts(mips32r1_if0.Interrupts),            // 5 general-purpose hardware interrupts
    .NMI(mips32r1_if0.NMI),                         // Non-maskable interrupt
    // Data Memory Interface
    .DataMem_In(mips32r1_if0.DataMem_In),
    .DataMem_Ack(mips32r1_if0.DataMem_Ack),
    .DataMem_Read(mips32r1_if0.DataMem_Read),
    .DataMem_Write(mips32r1_if0.DataMem_Write),        // 4-bit Write, one for each byte in word.
    .DataMem_Address(mips32r1_if0.DataMem_Address),      // Addresses are words, not bytes.
    .DataMem_Out(mips32r1_if0.DataMem_Out),
    // Instruction Memory Interface
    .InstMem_In(mips32r1_if0.InstMem_In),
    .InstMem_Address(mips32r1_if0.InstMem_Address),      // Addresses are words, not bytes.
    .InstMem_Ack(mips32r1_if0.InstMem_Ack),
    .InstMem_Read(mips32r1_if0.InstMem_Read),
    .IP(mips32r1_if0.IP) );

  

  initial begin
  	uvm_config_db #(virtual mips32r1_if)::set(uvm_root::get(),"*","trans", mips32r1_if0);
  end
  
  initial begin
    run_test("mips32r1_test");
  end

  
endmodule
