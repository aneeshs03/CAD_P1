package Multiplier1;

// Define a 32-bit signed multiplier interface
interface SignedMultiplierIfc;
  method Action start(Int#(32) multiplicand, Int#(32) multiplier);
  method Action done();
  method Int#(64) getResult();
endinterface

// Implement the pipelined signed multiplier
module mkPipelinedSignedMultiplier (SignedMultiplierIfc);
  // Pipeline registers
  Reg#(Int#(32)) multiplicandReg <- mkReg(0);
  Reg#(Int#(32)) multiplierReg <- mkReg(0);
  Reg#(Int#(64)) productReg <- mkReg(0);

  // Control signals for pipeline stages
  Reg#(Bool) startStage <- mkReg(True);
  Reg#(Bool) multiplyStage <- mkReg(False);
  Reg#(Bool) accumulateStage <- mkReg(False);

  // Consolidated rule for pipeline stages: Multiply and Accumulate
rule processStages;
  // Use a nested if-else structure to achieve the desired conditions
  if (startStage) begin
    startStage <= False;

    if (multiplyStage) begin
      // Stage 1: Multiply
      multiplyStage <= False;
      productReg <= extend(multiplicandReg) * extend(multiplierReg);
    end else if (accumulateStage) begin
      // Stage 2: Accumulate
      accumulateStage <= False;
      productReg <= productReg + ((zeroExtend(multiplicandReg) << 32) >> 32);
    end
  end
endrule



  // Interface method to signal the end of computation
  method Action done();
    accumulateStage <= False;
  endmethod

  // Interface method to get the result
  method Int#(64) getResult();
    return productReg;
  endmethod

  // Interface method to start the multiplication
  method Action start(Int#(32) multiplicand, Int#(32) multiplier);
    // Reset pipeline registers
    multiplicandReg <= multiplicand;
    multiplierReg <= multiplier;
    productReg <= 0;
    startStage <= True;
    multiplyStage <= False;
    accumulateStage <= False;
  endmethod

endmodule

endpackage

