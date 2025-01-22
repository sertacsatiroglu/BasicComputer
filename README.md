# Basic Computer
Here’s a detailed **README.md** file you can use for your GitHub repository. It explains the purpose of your project, the structure of the files, and how to use the design.

---

# **Basic Computer Design in Verilog**

This repository contains the Verilog implementation of a **Basic Computer Design** following classical computer architecture principles. It includes a controller, datapath, memory unit, and testbench for simulation and verification. The design simulates the instruction fetch-decode-execute cycle, executing a predefined set of instructions stored in memory.

## **Features**
- **16-bit Data Width** and **12-bit Address Width**.
- Supports basic instructions like `LOAD`, `STORE`, `ADD`, `SUBTRACT`, and `HALT`.
- Integrated **ALU** for arithmetic and logical operations.
- **Timing and Control Signals** for instruction sequencing (`T0` to `T9`).
- Modular design for easy understanding and extensibility.

---

## **File Structure**
The repository includes the following files:

### **Core Modules**
| File               | Description                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| `ALU.v`            | Arithmetic Logic Unit for performing arithmetic and logical operations.     |
| `controller.v`     | Generates control signals and manages instruction decoding and sequencing.  |
| `datapath.v`       | Handles data flow between registers, memory, and the ALU.                  |
| `memory_unit.v`    | Simulates a 16-bit, 4K memory for storing instructions and data.            |
| `decoder.v`        | Decodes sequence counter and opcode signals for timing and control.         |
| `register.v`       | Implements general-purpose and special-purpose registers.                  |
| `MUX.v`            | Multiplexer to manage data routing in the datapath.                        |

### **Top-Level and Testbench**
| File               | Description                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| `BC_I.v`           | Top-level module that integrates all components of the basic computer.      |
| `BC_I_tb.v`        | Testbench for simulating and verifying the functionality of the computer.   |

---

## **Instruction Set**
The computer executes instructions stored in memory. Each instruction is 16 bits, with the format:

```
| Opcode (3 bits) | Address (12 bits) |
```

### Supported Instructions:
-> MEMORY : AND,ADD,STA, LDA, BUN, BSA, ISZ (Both direct and indirect)
-> REGISTER : CLA,CME, CMA, CLE, CIR, CIL, INC, SPA, SNA, SZA, SZE, HLT
Also ION, IEN
---

## **Getting Started**

### **1. Prerequisites**
You will need:
- A Verilog simulator (e.g., [Icarus Verilog](https://iverilog.fandom.com/wiki/Installation)).
- A waveform viewer (e.g., [GTKWave](http://gtkwave.sourceforge.net/)).

### **2. Clone the Repository**
```bash
git clone https://github.com/yourusername/basic-computer-design.git
cd basic-computer-design
```

### **3. Simulate the Design**
1. Compile the testbench:
   ```bash
   iverilog -o BC_I_tb.vvp BC_I_tb.v
   ```
2. Run the simulation:
   ```bash
   vvp BC_I_tb.vvp
   ```
3. (Optional) View waveforms:
   Add the following to `BC_I_tb.v`:
   ```verilog
   initial begin
       $dumpfile("waveform.vcd");
       $dumpvars(0, BC_I_tb);
   end
   ```
   Then open the waveform:
   ```bash
   gtkwave waveform.vcd
   ```

### **4. Memory Initialization**
The testbench initializes the memory with the following program:
```verilog
mem[0] = 16'h7020;  // Example: LOAD instruction
mem[1] = 16'h7020;  // ...
mem[2] = 16'h7040;  // ...
mem[3] = 16'h7800;  // HALT
```
Modify `initialize_memory` in `BC_I_tb.v` to change the program.

---

## **How It Works**
1. **Instruction Fetch**:
   - The Program Counter (`PC`) points to the next instruction in memory.
   - The instruction is fetched into the Instruction Register (`IR`).

2. **Instruction Decode**:
   - The `controller` decodes the opcode and generates control signals.
   - Timing signals (`T0` to `T9`) control the sequence of execution.

3. **Instruction Execute**:
   - The operation is performed based on the decoded instruction.
   - Data flows between the registers, memory, and ALU.

4. **Program Execution**:
   - Execution continues until a `HALT` instruction is encountered.

---

## **Waveform Analysis**
Use the waveform viewer to inspect:
- **Timing Signals**: `T0` to `T9`.
- **Register Values**: `PC`, `AC`, `IR`, etc.
- **Control Signals**: Decoder outputs (`D0` to `D7`).
- **Data Flow**: Monitor the `data_bus` and memory interactions.

---

## **Contributing**
Contributions are welcome! If you have improvements or find issues, feel free to:
1. Fork the repository.
2. Create a branch for your changes.
3. Submit a pull request.

---

## **Acknowledgments**
- Inspired by the design of a classical basic computer from educational computer architecture courses.
- Special thanks to [Icarus Verilog](https://iverilog.fandom.com/wiki/Installation) and [GTKWave](http://gtkwave.sourceforge.net/) for their tools.

---
