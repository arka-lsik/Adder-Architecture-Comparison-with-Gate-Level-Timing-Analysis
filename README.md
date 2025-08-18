# 🚀 N-bit Full Adder Implementation (32-bit Ripple Carry Adder)

This project implements a **parameterized N-bit ripple carry adder** in Verilog.  
The design is built hierarchically:  
- **1-bit Full Adder** → **8-bit Ripple Carry Adder** → **32-bit Ripple Carry Adder**.  
A testbench is also included to validate the design with random test vectors.  

---

## 📂 Project Structure
- `full_adder.v` → 1-bit full adder with delay modeling  
- `full_adder_n.v` → 8-bit ripple carry adder (using 1-bit FA instances)  
- `adder.v` → 32-bit adder (using four 8-bit blocks)  
- `tb_adder.v` → Testbench for simulation  

---

## 🔹 Design Details

### 1. **1-bit Full Adder (`Full_Adder`)**
Implements basic addition with gate delays:
- `Sum = (in1 ^ in2) ^ cin`  
- `Cout = (in1 & in2) | (in1 & cin) | (in2 & cin)`  

### 2. **8-bit Ripple Carry Adder (`Full_Adder_N`)**
- Chains 8 full adders together.  
- Propagates carry through each stage.  
- Uses **generate-for loop** for compact instantiation.  

### 3. **32-bit Adder (`Adder`)**
- Instantiates four 8-bit ripple carry adders.  
- Outputs **registered sum and carry** on positive clock edge (`TClk`).  

---

## ⏱️ Critical Path Delay
For one 8-bit ripple carry block:  
- `isum = 2 units`  
- `sum = 4 units`  
- `carry = 2 units`  
- **Critical Path = (2 + 2) × 8 = 32 time units**  

---

## 🧪 Testbench (`TB_Adder`)
The testbench applies **random stimulus** for verification:  
- Generates clock (`10 ns` period).  
- Applies 1000 random input vectors (`ra`, `rb`, `cin`).  
- Captures outputs `Sum` and `Cout`.  
- Dumps waveform to **VCD file** for GTKWave/ModelSim viewing.  

### Sample Log Output:
