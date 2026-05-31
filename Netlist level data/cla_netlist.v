module cla(a, b, cin, sum, cout);
  input [31:0] a;
  wire [31:0] a;
  input [31:0] b;
  wire [31:0] b;
  wire [8:0] carry;
  input cin;
  wire cin;
  output cout;
  wire cout;
  output [31:0] sum;
  wire [31:0] sum;
  cla_4bit \cla_chain[0].blk  (
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(cin),
    .cout(carry[1]),
    .sum(sum[3:0])
  );
  cla_4bit \cla_chain[1].blk  (
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(carry[1]),
    .cout(carry[2]),
    .sum(sum[7:4])
  );
  cla_4bit \cla_chain[2].blk  (
    .a(a[11:8]),
    .b(b[11:8]),
    .cin(carry[2]),
    .cout(carry[3]),
    .sum(sum[11:8])
  );
  cla_4bit \cla_chain[3].blk  (
    .a(a[15:12]),
    .b(b[15:12]),
    .cin(carry[3]),
    .cout(carry[4]),
    .sum(sum[15:12])
  );
  cla_4bit \cla_chain[4].blk  (
    .a(a[19:16]),
    .b(b[19:16]),
    .cin(carry[4]),
    .cout(carry[5]),
    .sum(sum[19:16])
  );
  cla_4bit \cla_chain[5].blk  (
    .a(a[23:20]),
    .b(b[23:20]),
    .cin(carry[5]),
    .cout(carry[6]),
    .sum(sum[23:20])
  );
  cla_4bit \cla_chain[6].blk  (
    .a(a[27:24]),
    .b(b[27:24]),
    .cin(carry[6]),
    .cout(carry[7]),
    .sum(sum[27:24])
  );
  cla_4bit \cla_chain[7].blk  (
    .a(a[31:28]),
    .b(b[31:28]),
    .cin(carry[7]),
    .cout(cout),
    .sum(sum[31:28])
  );
   assign { carry[8], carry[0] } = { cout, cin };
endmodule

module cla_4bit(a, b, cin, sum, cout, pg, gg);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  input [3:0] a;
  wire [3:0] a;
  input [3:0] b;
  wire [3:0] b;
  wire [4:0] c;
  input cin;
  wire cin;
  output cout;
  wire cout;
  output gg;
  wire gg;
  output pg;
  wire pg;
  output [3:0] sum;
  wire [3:0] sum;
  sky130_fd_sc_hd__nand2_1 _14_ (
    .A(a[0]),
    .B(b[0]),
    .Y(_00_)
  );
  sky130_fd_sc_hd__xnor2_1 _15_ (
    .A(a[0]),
    .B(b[0]),
    .Y(_01_)
  );
  sky130_fd_sc_hd__nand2_1 _16_ (
    .A(a[1]),
    .B(b[1]),
    .Y(_02_)
  );
  sky130_fd_sc_hd__lpflow_inputiso1p_1 _17_ (
    .A(a[1]),
    .SLEEP(b[1]),
    .X(_03_)
  );
  sky130_fd_sc_hd__xnor2_1 _18_ (
    .A(a[1]),
    .B(b[1]),
    .Y(_04_)
  );
  sky130_fd_sc_hd__nand2_1 _19_ (
    .A(a[2]),
    .B(b[2]),
    .Y(_05_)
  );
  sky130_fd_sc_hd__xnor2_1 _20_ (
    .A(a[2]),
    .B(b[2]),
    .Y(_06_)
  );
  sky130_fd_sc_hd__xnor2_1 _21_ (
    .A(a[3]),
    .B(b[3]),
    .Y(_07_)
    );
  sky130_fd_sc_hd__nor2_1 _22_ (
    .A(_06_),
    .B(_07_),
    .Y(_08_)
  );
  sky130_fd_sc_hd__nor4_1 _23_ (
    .A(_01_),
    .B(_04_),
    .C(_06_),
    .D(_07_),
    .Y(pg)
  );
  sky130_fd_sc_hd__o21ai_0 _24_ (
    .A1(_00_),
    .A2(_04_),
    .B1(_02_),
    .Y(_09_)
  );
  sky130_fd_sc_hd__nor2_1 _25_ (
    .A(_05_),
    .B(_07_),
    .Y(_10_)
  );
  sky130_fd_sc_hd__a221o_1 _26_ (
    .A1(a[3]),
    .A2(b[3]),
    .B1(_08_),
    .B2(_09_),
    .C1(_10_),
    .X(gg)
  );
  sky130_fd_sc_hd__a21o_1 _27_ (
    .A1(cin),
    .A2(pg),
    .B1(gg),
    .X(cout)
  );
  sky130_fd_sc_hd__xnor2_1 _28_ (
    .A(cin),
    .B(_01_),
    .Y(sum[0])
  );
  sky130_fd_sc_hd__maj3_1 _29_ (
    .A(a[0]),
    .B(b[0]),
    .C(cin),
    .X(_11_)
  );
  sky130_fd_sc_hd__xnor2_1 _30_ (
    .A(_04_),
    .B(_11_),
    .Y(sum[1])
  );
  sky130_fd_sc_hd__a21boi_0 _31_ (
    .A1(_03_),
    .A2(_11_),
    .B1_N(_02_),
    .Y(_12_)
  );
  sky130_fd_sc_hd__xor2_1 _32_ (
    .A(_06_),
    .B(_12_),
    .X(sum[2])
  );
  sky130_fd_sc_hd__o21ai_0 _33_ (
    .A1(_06_),
    .A2(_12_),
    .B1(_05_),
    .Y(_13_)
  );
  sky130_fd_sc_hd__xnor2_1 _34_ (
    .A(_07_),
    .B(_13_),
    .Y(sum[3])
  );
  assign { c[4], c[0] } = { cout, cin };
endmodule
