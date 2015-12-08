module Multiplexer4to1(
  input       [7:0]in0,in1,in2,in3,
  input       [1:0]Asel,
  output reg  [7:0]out
  );
  
  always@(in0,in1,in2,in3,Asel)
  begin
    case(Asel)
      2'b00:  out=in0;
      2'b01:  out=in1;
      2'b10:  out=in2;
      2'b11:  out=in3;
      default out=in3;
     endcase
  end
    
  endmodule  