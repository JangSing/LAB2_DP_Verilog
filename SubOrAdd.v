module SubOrAdd(
  input      [7:0]inA,inM,
  input      Sub,
  output reg [7:0]out
  );

  always@(Sub)
   begin
    if(Sub)
      out=inA-inM;
    else
      out=inA+inM;
   end

  endmodule 

