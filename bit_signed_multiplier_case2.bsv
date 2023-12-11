package bit_signed_multiplier_case1;

import Connectable::*;
import RegFile::*;

interface MultiplierIfc;
  method Action start(Bit#(64) multiplicand,Bit#(64) multiplier);
  method Bit#(128) getResult();
endinterface

module mkbit_signed_multiplier (MultiplierIfc);

  Reg#(Bit#(128)) multiplicand128 <- mkReg(0);
  Reg#(Bit#(128)) productReg <- mkReg(0);
  Reg#(Bit#(128)) productResult <- mkReg(0);
  Reg#(Bit#(64)) multiplicand_twos <- mkReg(0);
  Reg#(Bit#(64)) multiplier_twos <- mkReg(0);
  Reg#(Bit#(128)) variables<- mkReg(0);

  method Action start(Bit#(64) multiplicand, Bit#(64) multiplier);
    productReg <= 0;
    multiplicand_twos <= (-multiplicand) + 1;
    multiplier_twos <= (-multiplier) + 1;
    
    
    if (multiplicand[63] == 0 && multiplier[63] == 0) begin
    multiplicand128 <= zeroExtend(multiplicand);
      for (Integer i = 0; i < 64; i = i + 1) begin
        if (multiplier[i] == 1) begin
        productReg <= productReg + (multiplicand128 << i);

        end
      end
      productResult <= productReg;
    end

  else if (multiplicand[63] ==1 && multiplier[63] == 0) begin
  multiplicand128 <= zeroExtend(multiplicand_twos);
  for (Integer i = 0; i < 64; i = i + 1) begin
   variables <= 128'b1111111111111111111111111111111111111111111111111111111111111111000000000000000000000000000000000000000000000000000000000000000
;
      if (multiplier[i] ==1) begin
        productReg <= productReg +((variables<< 1) + (multiplicand128 << i));
      end
     end
  productResult <= (-productReg) + 1;
  end

  else if (multiplicand[63] == 1 && multiplier[63] == 1) begin  
  multiplicand128 <= zeroExtend(multiplicand_twos);
  for (Integer i = 0; i < 63; i = i + 1) begin
      variables <= 128'b1111111111111111111111111111111111111111111111111111111111111111000000000000000000000000000000000000000000000000000000000000000
;
      if (multiplier_twos[i] == 1) begin
        productReg <= productReg + ((variables<< 1) + (multiplicand128 << i));
      end
     end
     
  productReg <= productReg + (-((variables << 1)+ (multiplicand128 << 63)) + 1);
  productResult <= productReg;
  end
  
  else if (multiplicand[63] == 0 && multiplier[63] ==1) begin  
  multiplicand128 <= zeroExtend(multiplicand);
  for (Integer i = 0; i < 63; i = i + 1) begin
   
      if (multiplier_twos[i] == 1) begin
        productReg <= productReg + (multiplicand128 << i);
      end
   end

  productReg <= productReg + (-(multiplicand128 << 63) + 1); 

  productResult <= (-productReg) + 1;
  end

  else begin
    productResult <= 0;
  end

endmethod
  // Interface method to get the result
   method Bit#(128) getResult();
  return productResult;
  endmethod

endmodule

endpackage


