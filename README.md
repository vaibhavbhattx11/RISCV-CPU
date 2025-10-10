# RISC-V CPU

This repository contains an implementation of a **two-phase pipelined RISC-V CPU** built entirely from scratch in **Logisim-Evolution**.  
The CPU supports almost all **RV32I** base instructions and demonstrates the complete datapath and control flow of a modern RISC-V processor.

Currently, this CPU **does not support unaligned memory accesses** — that is, instructions like `lw`, `sw`, `lh`, and `sh` will only function correctly when their target addresses are word-aligned.

Below, I’ve summarized the major components, their design details, and how testing is performed.

---

## Individual Components

### Datapath
The **datapath** represents the main execution flow of the CPU, connecting all functional units — ALU, register file, memory interface, control unit, and others — to carry out each instruction.

#### Design
<img width="1900" height="788" alt="Datapath Design" src="https://github.com/user-attachments/assets/5dcf02b4-bd43-4ec9-9da6-501401455c65" />
<br>

---

### Control Unit
The **control unit** decodes the instruction and generates the necessary control signals to correctly route data through the datapath for each instruction type.

#### Design
<img width="1378" height="984" alt="Control Unit" src="https://github.com/user-attachments/assets/f47feba6-56c8-4c5b-a728-15faa0e7a79f" />
<br>

---

### ALU
The **Arithmetic Logic Unit (ALU)** performs arithmetic and logical operations.  
Each operation is implemented using basic logic circuits, and a multiplexer is used to select the appropriate result.

#### Design
<img width="1396" height="1048" alt="ALU Design" src="https://github.com/user-attachments/assets/35327c8a-930f-412f-a896-369cbfd3ca1e" />
<br>

---

### Register File
The **register file** consists of 32 general-purpose registers.  
Write enable signals are demultiplexed to the target register (`rd`), while `x0` is hardwired to zero.  
Outputs for `rs1` and `rs2` are multiplexed to provide operands to the datapath.

#### Design
<img width="1223" height="1230" alt="Register File" src="https://github.com/user-attachments/assets/2e09672f-4a9c-4176-a593-d6c4ee36887a" />
<br>

---

### Immediate Generator
The **immediate generator** extracts and sign-extends the immediate field from the instruction based on its type (I, S, B, U, or J).

#### Design
<img width="1394" height="685" alt="Immediate Generator" src="https://github.com/user-attachments/assets/aa424f2d-afd1-4694-9474-cd50cf1f1caf" />
<br>

---

### Branch Comparator
The **branch comparator** generates equality and less-than signals (for both signed and unsigned comparisons).  
These are used by the control unit to decide branch and jump outcomes.

#### Design
<img width="1088" height="353" alt="Branch Comparator" src="https://github.com/user-attachments/assets/1a1ecc3e-3000-44fd-8dec-15fa6222e19b" />
<br>

---

## ISA Testing

CPU correctness is verified through a custom **Python testing framework** that:

1. Runs RISC-V assembly programs on both the **Venus simulator** ([https://venus.cs61c.org/](https://venus.cs61c.org/)) and this CPU.  
2. Compares register states after each instruction.  
3. Reports mismatches, helping identify any datapath or control issues.

The CPU passes all standard test cases and numerous **custom test programs** covering every instruction type.  
Additionally, I generated complex test programs (e.g., Fibonacci sequence generation) using LLMs to validate control flow and memory operations.

#### Test Output
<img width="710" height="479" alt="Testing Output" src="https://github.com/user-attachments/assets/ef6f1b18-1a7a-4bf6-acfa-cb024fc5b689" />
<br>


