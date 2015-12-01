`timescale 1ps/1ps

module DP_tb();
   reg  Reset,Clock;
   reg  [7:0]Input;
   reg  IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt;
   reg  [1:0]Asel;
   wire Aeq0;
   wire Apos;
   wire [7:0]Output;
   wire [2:0]IR;
   wire [4:0]MeminstOut;
   wire [7:0]RAMout;
   
   integer i=0;
   
   
//always triggerring the clock
  initial
   begin
    Clock <= 0;
    forever #1 Clock=~Clock;
   end

//the Reset block 
  initial
   begin
    Reset <= 0;
    @(posedge Clock);
    @(negedge Clock) Reset=1;
   end   
       
  task inputData;
    input [7:0]inData;
    begin
       @(negedge Clock) Input=inData;Asel=2'b01;Aload=1;
       @(negedge Clock); 
       Aload=0;
       // $display("Output=%b.",Output);
    end
  endtask
 
 
  task storingData();
    begin
     for(i=0;i<6;i=i+1)
      begin
       //register A testing
       @(negedge Clock) Input={$random};Asel=2'b01;Aload=1;
       @(negedge Clock); 
       $display("Input=>\tAt time %0d\tps:\t\tIR=%b\tOutput=%b",$time,IR,Output);
       Aload=0;
      
       //PC register, IR register, RAM testing 
       @(negedge Clock) PCload=1;
       @(negedge Clock) MemWr=1;PCload=0;
       @(negedge Clock) MemWr=0;  
       @(negedge Clock) IRload=1;
        
       @(negedge Clock); 
       $display("store=>\tAt time %0d\tps:\t\tIR=%b\tOutput=%b\n",$time,IR,Output);
       IRload=0;
      end 
  end
  endtask 

  task jpos();
    begin
      @(negedge Clock) inputData(8'b01000100);
      $display("Input=>\tAt time %0d\tps:\t\tIR=%b\tOutput=%b",$time,IR,Output);
      @(negedge Clock) PCload=1;
      @(negedge Clock) MemWr=1;PCload=0;
      @(negedge Clock) MemWr=0;  
      @(negedge Clock) IRload=1;
      @(negedge Clock);
      $display("store=>\tAt time %0d\tps:\t\tIR=%b\tOutput=%b",$time,IR,Output);
      @(negedge Clock) JMPmux=1;PCload=1;
      @(negedge Clock); //one clk cycle to load the PC
      @(negedge Clock); //one clk cycle to read data from RAM
      @(negedge Clock); //one clk cycle to load the IR
      @(negedge Clock); $display("jpos=>\tAt time %0d\tps:\t\tIR=%b\tOutput=%b",$time,IR,Output);    
    end
  endtask  
  
  initial 
   begin
   {Input,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,Asel}=0;
   repeat (2) @(negedge Clock);
   storingData();
   jpos();
   
   
 end
  DP testDP(Reset,Clock,Input,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,Asel,Aeq0,Apos,Output,IR,MeminstOut,RAMout);
   
endmodule
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   