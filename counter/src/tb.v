module tb
  (input clk_i
  ,input rst_i);

  logic [7:0] cnt;

  always_ff @(posedge clk_i)
    if (rst_i)
      cnt <= '0;
    else
      cnt <= cnt + 1;

  always_ff @(posedge clk_i)
    if (~rst_i)
      $display("counter:%04d", cnt);

endmodule
