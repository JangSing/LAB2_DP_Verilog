module RAM32x8(
  input       MemWr,Clock,
  input       [4:0]Address,
  input       [7:0]D,
  output reg  [7:0]Q
  );
  
  reg [7:0]Mem[31:0];
  
  always@(posedge Clock)
   begin 
    if(MemWr)
      Mem[Address] <= D;
    else
      Q <= Mem[Address];
   end
  
  
  endmodule 