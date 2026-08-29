// Four-bit structural CLA block used by the hierarchical bonus adder.
module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);
  wire [3:0] p, g;
  wire [4:0] c;
  xor #(2) p0(p[0], a[0], b[0]);
  xor #(2) p1(p[1], a[1], b[1]);
  xor #(2) p2(p[2], a[2], b[2]);
  xor #(2) p3(p[3], a[3], b[3]);
  and #(2) g0(g[0], a[0], b[0]);
  and #(2) g1(g[1], a[1], b[1]);
  and #(2) g2(g[2], a[2], b[2]);
  and #(2) g3(g[3], a[3], b[3]);
  assign #(2) c[0] = cin;
  assign #(2) c[1] = g[0] | (p[0] & c[0]);
  assign #(2) c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
  assign #(2) c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) |
                     (p[2] & p[1] & p[0] & c[0]);
  assign #(2) c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) |
                     (p[3] & p[2] & p[1] & g[0]) |
                     (p[3] & p[2] & p[1] & p[0] & c[0]);
  xor #(2) s0(sum[0], p[0], c[0]);
  xor #(2) s1(sum[1], p[1], c[1]);
  xor #(2) s2(sum[2], p[2], c[2]);
  xor #(2) s3(sum[3], p[3], c[3]);
  assign #(2) cout = c[4];
endmodule
