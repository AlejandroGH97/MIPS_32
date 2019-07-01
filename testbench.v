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
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
  #100
  clk=1'b1;
  #100
  clk=1'b0;
end

endmodule
