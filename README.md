# RISC-V CPU
I am implementing a complete RISC-V CPU from scratch using Logisim-Evolution capable of handling almost all RV32I instructions.  
I have briefed implementation details and design images below. [IN PROGRESS]

## Individual Components
Below are the designs for the major components of the CPU I have implemented.

### ALU
Following is the design for the Arithmetic Logic Unit (ALU). I have created simple logical circuits for each operation and used a multiplexer to direct the output. 

#### Design:
<img width="1396" height="1048" alt="Screenshot 2025-09-15 172137" src="https://github.com/user-attachments/assets/35327c8a-930f-412f-a896-369cbfd3ca1e" />
<br>


### Register File
Following is the design for the register-file. It has 32 registers. Write enable has been demuxed(hardwired to 0 for x0) to its corresponding register rd, and write data is provided to all the registers. The output from each register is muxed to provide the required data for rs1 and rs2 for final outputs.

#### Design:
<img width="1223" height="1230" alt="Screenshot 2025-09-15 173352" src="https://github.com/user-attachments/assets/2e09672f-4a9c-4176-a593-d6c4ee36887a" />

<br>

### Immediate Generator
This component provides the imm value of the required type by fetching the relevant bits from the instruction input.

#### Design:
<img width="1394" height="685" alt="Screenshot 2025-09-15 172844" src="https://github.com/user-attachments/assets/aa424f2d-afd1-4694-9474-cd50cf1f1caf" />
<br>

### Branch Comparator
This component provides the branch-equal and branch-less-than signal values for signed/unsigned options, that are used as part of our control logic for handling branch and jump operations.

#### Design:
<img width="1088" height="353" alt="Screenshot 2025-09-15 173617" src="https://github.com/user-attachments/assets/1a1ecc3e-3000-44fd-8dec-15fa6222e19b" />
<br>
