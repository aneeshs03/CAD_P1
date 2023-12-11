package bit_signed_multiplier_case1;

import Connectable::*;
import RegFile::*;

interface MultiplierIfc;
  method Action start(Bit#(32) multiplicand,Bit#(32) multiplier);
  method Bit#(64) getResult();
endinterface

module mkbit_signed_multiplier (MultiplierIfc);

  Reg#(Bit#(64)) multiplicand64 <- mkReg(0);
  Reg#(Bit#(32)) bitmultiplier <- mkReg(0);
  Reg#(Bit#(64)) productReg <- mkReg(0);
  Reg#(Bit#(64)) productResult <- mkReg(0);
  Reg#(Bit#(32)) multiplicand_twos <- mkReg(0);
  Reg#(Bit#(32)) multiplier_twos <- mkReg(0);
  Reg#(Bit#(64)) variables<- mkReg(0);

  method Action start(Bit#(32) multiplicand, Bit#(32) multiplier);
    productReg <= 0;
    multiplicand_twos <= (-multiplicand) + 1;
    multiplier_twos <= (-multiplier) + 1;
    
    
    if (multiplicand[31] == 0 && multiplier[31] == 0) begin
    multiplicand64 <= zeroExtend(multiplicand);
      for (Integer i = 0; i < 32; i = i + 1) begin
        if (multiplier[i] == 1) begin
        productReg <= productReg + (multiplicand64 << i);

        end
      end
      productResult <= productReg;
    end

  else if (multiplicand[31] ==1 && multiplier[31] == 0) begin
  multiplicand64 <= zeroExtend(multiplicand_twos);
  for (Integer i = 0; i < 32; i = i + 1) begin
   variables <= 64'b1111111111111111111111111111111100000000000000000000000000000000;
      if (multiplier[i] ==1) begin
        productReg <= productReg +((variables<< 1) + (multiplicand64 << i));
      end
     end
  productResult <= (-productReg) + 1;
  end

  else if (multiplicand[31] == 1 && multiplier[31] == 1) begin  
  multiplicand64 <= zeroExtend(multiplicand_twos);
  for (Integer i = 0; i < 31; i = i + 1) begin
      variables <= 64'b1111111111111111111111111111111100000000000000000000000000000000;
      if (multiplier_twos[i] == 1) begin
        productReg <= productReg + ((variables<< 1) + (multiplicand64 << i));
      end
     end
     
  productReg <= productReg + (-((variables << 1)+ (multiplicand64 << 31)) + 1);
  productResult <= productReg;
  end
  
  else if (multiplicand[31] == 0 && multiplier[31] ==1) begin  
  multiplicand64 <= zeroExtend(multiplicand);
  for (Integer i = 0; i < 31; i = i + 1) begin
   
      if (multiplier_twos[i] == 1) begin
        productReg <= productReg + (multiplicand64 << i);
      end
   end

  productReg <= productReg + (-(multiplicand64 << 31) + 1); 

  productResult <= (-productReg) + 1;
  end

  else begin
    productResult <= 0;
  end

endmethod
  // Interface method to get the result
   method Bit#(64) getResult();
  return productResult;
  endmethod

endmodule

endpackage


