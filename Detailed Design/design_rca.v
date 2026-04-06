//Project - N bit Full Adder Implementation
//(parametrized N=32)


//code of one full Adder
module Full_Adder(in1,in2,cin,Sum,cout);
        input in1,in2,cin;
        output Sum,cout;
        wire i_sum;
        wire i_carry1,i_carry2,i_carry3;
  
        assign #2 i_sum=in1 ^ in2;
        assign #1 i_carry1=in1 & in2;
        assign #1 i_carry2=in1 & cin;
        assign #1 i_carry3=in2 & cin;
        assign #2 cout=i_carry1 | i_carry2 | i_carry3;
        assign #4 Sum= i_sum ^ cin;
endmodule


//instantiating the every full adderto make one 8 bit ripple carry 
module Full_Adder_N(ra,rb,cin,Sum,Cout);  
  input [7:0] ra;
  input [7:0] rb;
  input cin;
  output [7:0] Sum;
  output Cout;
  wire [8:0] Cinter;
        assign Cinter[0]=cin;
  		
  
        genvar i;
        generate
          for (i=0;i<8;i=i+1)  begin
                  
                  Full_Adder fa_inst(.in1(ra[i]),.in2(rb[i]),.cin(Cinter[i]),.Sum(Sum[i]),.cout(Cinter[i+1]));
                end
        endgenerate
	

  assign Cout=Cinter[8];
  
endmodule


//insiantiating one 8 bit ripple carry adder 4 times to make 32 bit adder
module Adder(TClk, ra, rb, cin, Sum, Cout);
    input [31:0] ra;
    input [31:0] rb;
    input cin, TClk;
    output reg [31:0] Sum;
    output reg Cout;

    wire [7:0] sum_parts[3:0];
    wire carry[4:0];

    assign carry[0] = cin;

    // Instantiate 4 Full_Adder_N modules for 32 bits
    Full_Adder_N fa0 (.ra(ra[7:0]),    .rb(rb[7:0]),    .cin(carry[0]), .Sum(sum_parts[0]), .Cout(carry[1]));
    Full_Adder_N fa1 (.ra(ra[15:8]),   .rb(rb[15:8]),   .cin(carry[1]), .Sum(sum_parts[1]), .Cout(carry[2]));
    Full_Adder_N fa2 (.ra(ra[23:16]),  .rb(rb[23:16]),  .cin(carry[2]), .Sum(sum_parts[2]), .Cout(carry[3]));
    Full_Adder_N fa3 (.ra(ra[31:24]),  .rb(rb[31:24]),  .cin(carry[3]), .Sum(sum_parts[3]), .Cout(carry[4]));

    always @(posedge TClk) begin
        Sum <= {sum_parts[3], sum_parts[2], sum_parts[1], sum_parts[0]};
        Cout <= carry[4];
    end
endmodule



// clock period  = critical path (2(for isum)+2(for sum))*8=32


//different way to write[parametrized way] the same functionality
module full_adder(input a,b,cin, 
				  output sum, cout);

	assign sum = a^b^cin;
	assign cout = (a & b) | (b & cin) | (cin & a);

endmodule

module ripple_c_adder #(parameter N =32)(
	input [N-1:0] a,b,
	input cin,
	output [N-1:0] sum,
	output cout);

	wire [N:0] carry; //theese are the internal carray connecting chain wire
	assign carry[0] = cin;

	genvar i;
	generate for(i = 0; i < N ; i++) 
		begin
		full_adder fa(.a(a[i]), .b(b[i]), .cin(carry[i], .sum(sum[i]), .cout(carry[i+1]));
		end
        endgenerate
		assign cout = carry[i];
	endmodule
	
	
