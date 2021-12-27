module encoder(
	input clk, A, B,
	output reg direction,
	output reg [6:0] counter 
	);
	
	reg [2:0] A_mem, B_mem;

	wire counter_en = A_mem[2] ^ A_mem[1] ^ B_mem[2] ^ B_mem[1];
	wire dir = A_mem[1] ^ B_mem[2];	
	
	always @(posedge clk)
	begin
	
		A_mem <= {A_mem[1:0], A}; // shift left and save new value
		B_mem <= {B_mem[1:0], B};
		
		if(counter_en)
		begin
			counter <= dir ? (counter + 1) : (counter - 1); // if(direction == 1) +1 else -1
			direction <= dir;
		end

	end
	
endmodule