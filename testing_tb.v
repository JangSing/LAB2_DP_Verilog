module testing_tb();
  reg       PCload,IRload;
  reg       MemWr,Clock,Reset;
 
  reg       [7:0]D;
  wire      [7:0]Q;
  wire [2:0]IR;
  wire [4:0]PCout,increOut;
  wire [7:0]IRout;
  wire [4:0]Mux1out,Mux2out;
  assign IR=IRout[7:5];
  
  
  Increment5bit      _5bitIncrement(PCout,increOut);
  nBitsRegister #(5) PCreg(PCload,Reset,Clock,Mux1out,PCout);
  /*
  RAM32x8 testRAM(MemWr,Clock,Mux2out,D,Q);
  nBitsRegister #(8) IRreg(IRload,Reset,Clock,Q,IRout); 
  */
  Multiplexer2to1 testMux1(increOut,5'b00000,1'b0,Mux1out);
  //Multiplexer2to1 testMux2(PCout,5'b00000,1'b0,Mux2out);
  
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
  
  initial
   begin 
    {IRload,PCload,MemWr}=0;
    D=8'b10101010;
    repeat (3) @(negedge Clock);
    @(negedge Clock) PCload=1;
    @(negedge Clock);PCload=0;
    @(negedge Clock) MemWr=1;
    @(negedge Clock) MemWr=0;  
    @(negedge Clock) IRload=1;       
    
   end
  
  
  
  
  
  
  endmodule 