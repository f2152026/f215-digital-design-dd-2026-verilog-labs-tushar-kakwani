// Structural, delay-annotated full adder reused by the task 3 RCA.
module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire p, ab, pc;
  xor #(2) xor_ab(p, a, b);
  and #(2) and_ab(ab, a, b);
  xor #(2) xor_sum(sum, p, cin);
  and #(2) and_pc(pc, p, cin);
  or  #(2) or_carry(cout, ab, pc);
endmodule
