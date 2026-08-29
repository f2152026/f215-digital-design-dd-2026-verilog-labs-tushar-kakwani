// cla64_blocked.v
// A practical 64-bit adder: sixteen 4-bit CLA blocks (your cla4.v),
// chained by feeding block k's carry-out into block (k+1)'s carry-in --
// the same instantiate-and-chain pattern as Task 2's ripple adder, just
// using 4-bit CLA blocks instead of single full adders.
//
// TODO: instantiate 16 cla4 blocks, named block0..block15, e.g.:
//   cla4 block0 (.a(a[3:0]),    .b(b[3:0]),    .cin(cin),  .sum(sum[3:0]),    .cout(c[1]));
//   cla4 block1 (.a(a[7:4]),    .b(b[7:4]),    .cin(c[1]), .sum(sum[7:4]),    .cout(c[2]));
//   ...
//   cla4 block15(.a(a[63:60]),  .b(b[63:60]),  .cin(c[15]),.sum(sum[63:60]),  .cout(cout));

module cla64_blocked(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [16:0] block_carry;
  assign #(2) block_carry[0] = cin;

  genvar block_id;
  generate
    for (block_id = 0; block_id < 16; block_id = block_id + 1) begin : cla_blocks
      cla4 block (
        .a(a[(block_id * 4) +: 4]),
        .b(b[(block_id * 4) +: 4]),
        .cin(block_carry[block_id]),
        .sum(sum[(block_id * 4) +: 4]),
        .cout(block_carry[block_id + 1])
      );
    end
  endgenerate

  assign #(2) cout = block_carry[16];

endmodule
