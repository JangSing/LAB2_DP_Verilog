module nBitsRegister(Load,Clear,Clock,D,Q);
  parameter     n=8;
  input         Load,Clear,Clock;
  input         [n-1:0]D;
  output reg    [n-1:0]Q;
  
  always@(posedge Clock,negedge Clear)
   begin 
    if(!Clear)
      Q <= 0;
    else
     begin 
      if(Load)
        Q <= D;
      else  
        Q <= Q;
     end
   end  
        
   endmodule 