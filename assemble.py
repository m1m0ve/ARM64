from ctypes import c_uint32

class ARMv8Instructions:
    def __init__(self):
        self.instructions = {
            'MOV_bitmask_immediate': self.mov_bitmask_immediate,
              
            # Add more instructions here as needed
        }

        self.registers = {
          # 64 bit 


          # 32 bit 
        }

    def mov_bitmask_immediate(self, dest_reg, imm,sf):
        opcode = c_uint32(0x320003E0)  # Base opcode for MOV (bitmask immediate) 32-bit
        opcode.value |= (dest_reg & 0x1F)
        imms = imm.bit_length() - 1
        opcode.value |= (imms & 0x3F) << 10
        return opcode.value

    def get_instruction(self, instruction_name, *args):
        if instruction_name in self.instructions:
            return self.instructions[instruction_name](*args)
        else:
            raise ValueError(f"Unknown instruction: {instruction_name}")

    @staticmethod
    def get_instruction_bytes(opcode):
        return opcode.to_bytes(4, byteorder='little')

# Usage
arm_instructions = ARMv8Instructions()

# MOV W0, #0x1
mov_opcode = arm_instructions.get_instruction('MOV_bitmask_immediate', 0, 0x1,0x1)
print(f"MOV W0, #0xFF (hex): {mov_opcode:08x}")
print(f"Instruction bytes: {ARMv8Instructions.get_instruction_bytes(mov_opcode).hex()}")
