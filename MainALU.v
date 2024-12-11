module MainALU(
    input signed [31:0] OperandA, OperandB, 
    input signed [3:0] ALUControlResult,
    input [4:0] shamt,

    output zero,
    output reg [31:0] ALUResult
);
    assign zero = ((OperandA - OperandB) == 0)? 1:0;
    always @(*) begin
        case (ALUControlResult)
            4'b0000: begin // AND
                ALUResult <= OperandA & OperandB;
            end 
            4'b0001: begin // OR
                ALUResult <= OperandA | OperandB;
            end
            4'b0010: begin // ADD
                ALUResult <= OperandA + OperandB; 
            end
            4'b0011: begin // SHIFT LEFT
                ALUResult <= OperandB << shamt;
            end
            4'b0100: begin // SHIFT RIGHT LOGICAL
                ALUResult <= OperandB >> shamt;
            end
            4'b0101: begin // SHIFT RIGHT ARTH
                ALUResult <= (OperandB>>>shamt);
            end
            4'b0110: begin // SUB
                ALUResult <= OperandA - OperandB;
            end
            4'b1010: begin // XOR
               ALUResult <= OperandA ^ OperandB;
            end
            default: begin
                ALUResult <= 32'b0;
            end
        endcase
    end
endmodule