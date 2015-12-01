module Increment5bit(
  input   [4:0]in,
  output  [4:0]out
  );
  
  assign out = in + 5'b00001;
  
  endmodule
  