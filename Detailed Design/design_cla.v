module carray_look_adder_4(
  input [3:0] a,b,
  input cin,
  output [3:0] sum,
  output cout);
  output gc, gg;

  wire [3:0] cg, cp;
  wire [4:0] c;

  assign c[0] = cin;
  assign cg = a^b;
  assign cp = a & b;

  assign c[1] = cp[0] | cg[0] & c[0];
  assign c[2] = cp[1] | P[1] & cp[0] | p[1] & cg[0] & c[0];
  assign c[3] = cp[2] | p[2] & cp[1] | p[2] & p[1] & cp[0] | p[2] & p[1] & cg[0] & c[0];
  assign c[4] = cp[3] | p[3] & cp[2] | p[3] & p[2] & cp[1] | p[3] & p[2] & p[1] & cp[0] | p[3] & p[2] & p[1] & cg[0] & c[0];

  assign cout = c[4];
  assign sum = cp ^ c[3:0];

  assign pg = &cp;
  assign gg = cg[3] | (cp[3] & cg[2]) | (cp[3] & cp[2] & cg[1]) | (cp[3] & cp[2] & cp[1] & cg[0]);

  endmodule

module cla #(parameter N = 32) (
    input  [N-1:0] a, b,
    input          cin,
    output [N-1:0] sum,
    output         cout );

    wire [N/4:0] carry;
    assign carry[0] = cin;

  genvar i;
    generate
        for (i = 0; i < N/4; i = i + 1) begin : 
          carry_look_adder_4 cla_chain(
            .a(a[4*i+3:4*i]), .b(b[4*i+3:4*i]), .cin(carry[i]), .sum(sum[4*i+3:4*i]), .cout(carry[i+1]), .pg(), .gg());
        end
    endgenerate
    assign cout = carry[N/4];
endmodule

 
  
  




















  
