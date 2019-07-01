module testbench;

reg clk;

datapath mipstest(clk);

initial begin
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;//stop 2 & 3
  // #100
  // clk=1'b1;
  // #100
  // clk=1'b0;
  // #100
  // clk=1'b1;
  // #100
  // clk=1'b0;//stop 1
end

endmodule
