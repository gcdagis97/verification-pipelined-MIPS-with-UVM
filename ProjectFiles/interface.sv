
interface mips32r1_if( input clk, input reset);  
	  
    logic instr;
    logic [4:0] Interrupts;
    logic NMI;
    logic  [31:0] DataMem_In;
    logic  DataMem_Ack;
    logic DataMem_Read;
    logic [3:0]  DataMem_Write;
    logic [29:0] DataMem_Address;      
    logic [31:0] DataMem_Out;
    logic  [31:0] InstMem_In;
    logic [29:0] InstMem_Address;      
    logic  InstMem_Ack;
    logic InstMem_Read;
    logic [7:0] IP;  
  
  //taken from design.sv
  clocking driver_cb @(posedge clk);
    output instr;
    input Interrupts;
    input NMI;
    input DataMem_In;
    input  DataMem_Ack;
    output DataMem_Read;
    output DataMem_Write;
    output DataMem_Address;      
    output DataMem_Out;
    input  InstMem_In;
    output InstMem_Address;      
    input  InstMem_Ack;
    output InstMem_Read;
    output IP;       
    endclocking
  
  clocking monitor_cb @(posedge clk);
    output instr;
    input Interrupts;
    input NMI;
    input  DataMem_In;
    input  DataMem_Ack;
    output DataMem_Read;
    output DataMem_Write;
    output DataMem_Address;      
    output DataMem_Out;
    input  InstMem_In;
    output InstMem_Address;      
    input  InstMem_Ack;
    output InstMem_Read;
    output IP;    
    endclocking
  
  
  modport DRIVER  (clocking driver_cb,input clk,reset);
  modport MONITOR  (clocking monitor_cb,input clk,reset);

endinterface: mips32r1_if
    
    