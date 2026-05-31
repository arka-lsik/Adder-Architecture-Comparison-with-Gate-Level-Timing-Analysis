module full_adder(a, b, cin, sum, cout);
  input a;
  wire a;
  input b;
  wire b;
  input cin;
  wire cin;
  output cout;
  wire cout;
  output sum;
  wire sum;
  sky130_fd_sc_hd__xor3_1 _0_ (
    .A(a),
    .B(b),
    .C(cin),
    .X(sum)
  );
  sky130_fd_sc_hd__maj3_1 _1_ (
    .A(a),
    .B(b),
    .C(cin),
    .X(cout)
  );
endmodule

module rca(a, b, cin, sum, cout);
  input [31:0] a;
  wire [31:0] a;
  input [31:0] b;
  wire [31:0] b;
  wire [32:0] carry;
  input cin;
  wire cin;
  output cout;
  wire cout;
  output [31:0] sum;
  wire [31:0] sum;
  full_adder \fa_chain[0].fa  (
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .cout(carry[1]),
    .sum(sum[0])
  );
  full_adder \fa_chain[10].fa  (
    .a(a[10]),
    .b(b[10]),
    .cin(carry[10]),
    .cout(carry[11]),
    .sum(sum[10])
  );
  full_adder \fa_chain[11].fa  (
    .a(a[11]),
    .b(b[11]),
    .cin(carry[11]),
    .cout(carry[12]),
    .sum(sum[11])
  );
  full_adder \fa_chain[12].fa  (
    .a(a[12]),
    .b(b[12]),
    .cin(carry[12]),
    .cout(carry[13]),
    .sum(sum[12])
  );
  full_adder \fa_chain[13].fa  (
    .a(a[13]),
    .b(b[13]),
    .cin(carry[13]),
    .cout(carry[14]),
     .sum(sum[13])
  );
  full_adder \fa_chain[14].fa  (
    .a(a[14]),
    .b(b[14]),
    .cin(carry[14]),
    .cout(carry[15]),
    .sum(sum[14])
  );
  full_adder \fa_chain[15].fa  (
    .a(a[15]),
    .b(b[15]),
    .cin(carry[15]),
    .cout(carry[16]),
    .sum(sum[15])
  );
  full_adder \fa_chain[16].fa  (
    .a(a[16]),
    .b(b[16]),
    .cin(carry[16]),
    .cout(carry[17]),
    .sum(sum[16])
  );
  full_adder \fa_chain[17].fa  (
    .a(a[17]),
    .b(b[17]),
    .cin(carry[17]),
    .cout(carry[18]),
    .sum(sum[17])
  );
  full_adder \fa_chain[18].fa  (
    .a(a[18]),
    .b(b[18]),
    .cin(carry[18]),
    .cout(carry[19]),
    .sum(sum[18])
    );
  full_adder \fa_chain[19].fa  (
    .a(a[19]),
    .b(b[19]),
    .cin(carry[19]),
    .cout(carry[20]),
    .sum(sum[19])
  );
  full_adder \fa_chain[1].fa  (
    .a(a[1]),
    .b(b[1]),
    .cin(carry[1]),
    .cout(carry[2]),
    .sum(sum[1])
  );
  full_adder \fa_chain[20].fa  (
    .a(a[20]),
    .b(b[20]),
    .cin(carry[20]),
    .cout(carry[21]),
    .sum(sum[20])
  );
  full_adder \fa_chain[21].fa  (
    .a(a[21]),
    .b(b[21]),
    .cin(carry[21]),
    .cout(carry[22]),
    .sum(sum[21])
  );
  full_adder \fa_chain[22].fa  (
    .a(a[22]),
    .b(b[22]),
    .cin(carry[22]),
    .cout(carry[23]),
    .sum(sum[22])
  );
  full_adder \fa_chain[23].fa  (
    .a(a[23]),
    .b(b[23]),
    .cin(carry[23]),
    .cout(carry[24]),
    .sum(sum[23])
  );
  full_adder \fa_chain[24].fa  (
    .a(a[24]),
    .b(b[24]),
    .cin(carry[24]),
    .cout(carry[25]),
    .sum(sum[24])
  );
  full_adder \fa_chain[25].fa  (
    .a(a[25]),
    .b(b[25]),
    .cin(carry[25]),
    .cout(carry[26]),
    .sum(sum[25])
  );
  full_adder \fa_chain[26].fa  (
    .a(a[26]),
    .b(b[26]),
    .cin(carry[26]),
    .cout(carry[27]),
    .sum(sum[26])
  );
  full_adder \fa_chain[27].fa  (
    .a(a[27]),
    .b(b[27]),
    .cin(carry[27]),
    .cout(carry[28]),
    .sum(sum[27])
  );
  full_adder \fa_chain[28].fa  (
     .a(a[28]),
    .b(b[28]),
    .cin(carry[28]),
    .cout(carry[29]),
    .sum(sum[28])
  );
  full_adder \fa_chain[29].fa  (
    .a(a[29]),
    .b(b[29]),
    .cin(carry[29]),
    .cout(carry[30]),
    .sum(sum[29])
  );
  full_adder \fa_chain[2].fa  (
    .a(a[2]),
    .b(b[2]),
    .cin(carry[2]),
    .cout(carry[3]),
    .sum(sum[2])
  );
  full_adder \fa_chain[30].fa  (
    .a(a[30]),
    .b(b[30]),
    .cin(carry[30]),
    .cout(carry[31]),
    .sum(sum[30])
  );
  full_adder \fa_chain[31].fa  (
    .a(a[31]),
    .b(b[31]),
    .cin(carry[31]),
    .cout(cout),
    .sum(sum[31])
  );
  full_adder \fa_chain[3].fa  (
    .a(a[3]),
    .b(b[3]),
    .cin(carry[3]),
    .cout(carry[4]),
    .sum(sum[3])
  );
  full_adder \fa_chain[4].fa  (
    .a(a[4]),
    .b(b[4]),
    .cin(carry[4]),
    .cout(carry[5]),
    .sum(sum[4])
  );
  full_adder \fa_chain[5].fa  (
    .a(a[5]),
    .b(b[5]),
    .cin(carry[5]),
    .cout(carry[6]),
    .sum(sum[5])
  );
  full_adder \fa_chain[6].fa  (
    .a(a[6]),
    .b(b[6]),
    .cin(carry[6]),
    .cout(carry[7]),
    .sum(sum[6])
  );
  full_adder \fa_chain[7].fa  (
    .a(a[7]),
    .b(b[7]),
    .cin(carry[7]),
    .cout(carry[8]),
    .sum(sum[7])
  );
  full_adder \fa_chain[8].fa  (
    .a(a[8]),
    .b(b[8]),
    .cin(carry[9]),
    .cout(carry[10]),
    .sum(sum[9])
  );
  assign { carry[32], carry[0] } = { cout, cin };
endmodule
