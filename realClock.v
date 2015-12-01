module realClock(
	input CLOCK_50,
	input [0:0]KEY,
	output reg CLOCK
);

integer count=0;
integer frequency;

always @(posedge CLOCK_50,negedge KEY[0])
begin	
	if(KEY[0]==0)
		count=0;
	else 
	begin
        if(count<25000000)
            count=count+1;
        else
         begin 
            CLOCK=~CLOCK;
            count=0;
         end
	end
end 	

endmodule 
