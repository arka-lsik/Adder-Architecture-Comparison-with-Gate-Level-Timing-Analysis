# 32-bit Adder Architecture Comparison with Gate-Level Timing Analysis

**Course Project | [VLSI System Design], IIT Kharagpur**  
**Tools:** Verilog HDL · Yosys · OpenSTA · Sky130 HD PDK

---

## Overview

This project implements and compares two 32-bit adder architectures — Ripple Carry Adder (RCA) and Carry Lookahead Adder (CLA) — through a complete RTL-to-STA flow using open-source EDA tools. The goal is to quantify the timing trade-off between the two designs across multiple PVT (Process-Voltage-Temperature) corners using real gate-level netlists and industry-standard static timing analysis.

The critical insight this project demonstrates: RCA has an O(N) carry chain that makes it fundamentally slow at 32-bit, while CLA computes carry signals in parallel through Generate/Propagate logic, achieving O(log N) depth — a 4.9× timing improvement at worst-case conditions.

---

## Repository Structure

```
adder_sta/
├── ripple_c_adder.v        # Parameterized N-bit RCA (full_adder + rca modules)
├── cla.v                   # Parameterized N-bit CLA (cla_4bit + cla modules)
├── synth_rca.ys            # Yosys synthesis script for RCA
├── synth_cla.ys            # Yosys synthesis script for CLA
├── constraints.sdc         # SDC timing constraints (5 ns max delay)
├── run_sta_rca.tcl         # OpenSTA script — RCA, TT corner
├── run_sta_cla.tcl         # OpenSTA script — CLA, TT corner
├── run_sta_rca_ff.tcl      # OpenSTA script — RCA, FF corner
├── run_sta_cla_ff.tcl      # OpenSTA script — CLA, FF corner
├── run_sta_rca_ss.tcl      # OpenSTA script — RCA, SS corner
├── run_sta_cla_ss.tcl      # OpenSTA script — CLA, SS corner
├── rca_netlist.v           # Gate-level netlist after Yosys synthesis
├── cla_netlist.v           # Gate-level netlist after Yosys synthesis
├── rca_timing_report.txt   # STA report — RCA TT corner
├── cla_timing_report.txt   # STA report — CLA TT corner
├── rca_ff_timing.txt       # STA report — RCA FF corner
├── cla_ff_timing.txt       # STA report — CLA FF corner
├── rca_ss_timing.txt       # STA report — RCA SS corner
└── cla_ss_timing.txt       # STA report — CLA SS corner
```

---

## Design Details

### Ripple Carry Adder (RCA)
- Built from a parameterized `full_adder` module chained using `generate`
- Carry propagates sequentially through all N stages
- Critical path = N × one full-adder delay → O(N) complexity
- Synthesized to **64 standard cells** (32× MAJ3 + 32× XOR3)

```verilog
module rca #(parameter N = 32) (
    input  [N-1:0] a, b,
    input          cin,
    output [N-1:0] sum,
    output         cout
);
```

### Carry Lookahead Adder (CLA)
- Built from parameterized 4-bit CLA blocks chained using `generate`
- Each block computes Generate (G) and Propagate (P) signals
- Carry computed in parallel across all blocks → O(log N) complexity
- Synthesized to **168 standard cells** (mix of AOI, OAI, XNOR, MAJ3 cells)

```verilog
module cla #(parameter N = 32) (
    input  [N-1:0] a, b,
    input          cin,
    output [N-1:0] sum,
    output         cout
);
```

---

## EDA Flow

### Step 1 — Synthesis (Yosys + Sky130 HD PDK)

```bash
yosys synth_rca.ys | tee rca_synth.log
yosys synth_cla.ys | tee cla_synth.log
```

Both designs are synthesized against the **Sky130 HD standard cell library** (sky130_fd_sc_hd), which is Google's open-source 130nm PDK. Yosys maps RTL constructs to real sky130 cells — MAJ3, XOR3, XNOR2, AOI, OAI gates — and writes out a gate-level netlist.

### Step 2 — Static Timing Analysis (OpenSTA)

```bash
sta -exit run_sta_rca.tcl | tee rca_timing_report.txt
sta -exit run_sta_cla.tcl | tee cla_timing_report.txt
```

SDC constraint used: `set_max_delay 5.0 -from [all_inputs] -to [all_outputs]`  
This sets a 5 ns (200 MHz equivalent) timing budget for purely combinational paths.

Reports generated: critical path trace, WNS (Worst Negative Slack), TNS (Total Negative Slack).

---

## PVT Corner Analysis

Three corners were analysed to simulate real-world chip operating conditions:

| Corner | Process | Voltage | Temperature | Condition |
|--------|---------|---------|-------------|-----------|
| FF | Fast-Fast | 1.95V | −40°C | Best case (fastest) |
| TT | Typical-Typical | 1.80V | 25°C | Nominal |
| SS | Slow-Slow | 1.60V | 100°C | Worst case (slowest) |

---

## Timing Results

### Critical Path Delay

| Corner | RCA Delay | CLA Delay | Speedup |
|--------|-----------|-----------|---------|
| FF (−40°C, 1.95V) | 6.279 ns | 1.686 ns | 3.7× |
| TT (25°C, 1.80V) | 12.197 ns | 2.835 ns | 4.3× |
| SS (100°C, 1.60V) | 26.925 ns | 5.493 ns | 4.9× |

### Slack Summary (5 ns constraint)

| Corner | RCA WNS | RCA Status | CLA WNS | CLA Status |
|--------|---------|------------|---------|------------|
| FF | −1.28 ns | ❌ VIOLATED | 0.00 ns | ✅ MET |
| TT | −7.20 ns | ❌ VIOLATED | 0.00 ns | ✅ MET |
| SS | −21.93 ns | ❌ VIOLATED | −0.49 ns | ❌ VIOLATED |

### Cell Count (Area vs Speed Trade-off)

| Design | Cell Count | Logic Depth |
|--------|-----------|-------------|
| RCA | 64 cells | O(N) |
| CLA | 168 cells | O(log N) |

CLA uses 2.6× more cells but achieves 4.3× better timing at typical corner — a clear area-speed trade-off.

---

## Critical Path Trace (TT Corner)

**RCA** — carry ripples through 32 MAJ3 gates sequentially:
```
cin → fa_chain[0].MAJ3 (0.363ns) → fa_chain[1].MAJ3 (0.384ns) → ... 
    → fa_chain[31].MAJ3 → cout
Total: 12.197 ns  |  slack: −7.197 ns  (VIOLATED)
```

**CLA** — carry computed in parallel 4-bit blocks, only 4 stages deep:
```
a[1] → XNOR2 → O21AI → A221O → A21O → [block carry chain] → MAJ3 → A21BOI → O21AI → XNOR2 → sum[31]
Total: 2.835 ns  |  slack: +2.165 ns  (MET)
```

---

## Key Observations

1. **RCA fails at all PVT corners** — even at FF (best case), the O(N) carry chain is too slow for 200 MHz at 32-bit width. This is a fundamental architectural limitation, not a synthesis issue.

2. **CLA meets timing at FF and TT corners** — only marginally fails at SS (worst case) by 0.49 ns, which could be fixed with minor timing optimization or a slightly relaxed constraint.

3. **Timing gap widens at SS corner** — slow transistors at high temperature and low voltage hurt the long RCA carry chain disproportionately (WNS goes from −1.28 ns at FF to −21.93 ns at SS), while CLA's short parallel path degrades more gracefully.

4. **SS corner is the signoff corner** — in real chip design, timing is always signed off at the worst-case SS corner. CLA nearly meets it; RCA is not even close.

---

## How to Reproduce

### Prerequisites
```bash
# Install Yosys
sudo apt install -y yosys

# Install OpenSTA dependencies
sudo apt install -y cmake tcl-dev swig bison flex git build-essential libeigen3-dev libgtest-dev libcudd-dev

# Build OpenSTA
git clone https://github.com/The-OpenROAD-Project/OpenSTA.git
cd OpenSTA && mkdir build && cd build
cmake -DSTA_BUILD_TESTS=OFF ..
make -j$(nproc)
sudo make install

# Get Sky130 liberty files
git clone --depth 1 https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_hd.git
cp skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__tt_025C_1v80.lib .
cp skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__ff_n40C_1v95.lib .
cp skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__ss_100C_1v60.lib .
```

### Run the full flow
```bash
# Synthesize
yosys synth_rca.ys | tee rca_synth.log
yosys synth_cla.ys | tee cla_synth.log

# Run STA — TT corner
sta -exit run_sta_rca.tcl | tee rca_timing_report.txt
sta -exit run_sta_cla.tcl | tee cla_timing_report.txt

# Run STA — FF corner
sta -exit run_sta_rca_ff.tcl | tee rca_ff_timing.txt
sta -exit run_sta_cla_ff.tcl | tee cla_ff_timing.txt

# Run STA — SS corner
sta -exit run_sta_rca_ss.tcl | tee rca_ss_timing.txt
sta -exit run_sta_cla_ss.tcl | tee cla_ss_timing.txt
```

---

## Tools & PDK

| Tool | Version | Purpose |
|------|---------|---------|
| Yosys | 0.33 | RTL synthesis, technology mapping |
| OpenSTA | 3.1.0 | Static timing analysis |
| Sky130 HD PDK | sky130_fd_sc_hd | Standard cell library (130nm) |

---

## Concepts Demonstrated

- **RTL design** — parameterized Verilog modules using `generate` and `genvar`
- **Logic synthesis** — technology mapping to real Sky130 standard cells via Yosys
- **Static Timing Analysis** — critical path extraction, WNS, TNS reporting using OpenSTA
- **PVT corner analysis** — FF/TT/SS corner comparison reflecting real chip operating conditions
- **Architecture trade-off** — area (cell count) vs timing (critical path depth) for adder designs
- **SDC constraints** — combinational path delay budgeting using `set_max_delay`

---

## Author

**Arkadeep Halder**  
M.Tech, VLSI & Signal Processing  
Indian Institute of Technology, Kharagpur  
[LinkedIn](https://linkedin.com) · [GitHub](https://github.com)
