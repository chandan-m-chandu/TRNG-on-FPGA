# FPGA-Based True Random Number Generator (TRNG) Using Metastability 

This project implements a high-speed, hardware-true random number generator (TRNG) on FPGA, based on the architecture described in the paper:

> F. Frustaci, F. Spagnolo, S. Perri and P. Corsonello, "A High-Speed FPGA-Based True Random Number Generator Using Metastability With Clock Managers," in IEEE Transactions on Circuits and Systems II: Express Briefs, vol. 70, no. 2, pp. 756-760, Feb. 2023, doi: 10.1109/TCSII.2022.3211278. 

---

##  Overview

This TRNG exploits physical unpredictability through:
- **Metastability in flip-flops**
- **Phase tuning via Digital Clock Manager (DCM)**
- **CARRY4-based fine delay chains**
- **Post-processing logic using DSP-like accumulator + conditional flip**

It generates **high-entropy 32-bit random words**, suitable for cryptographic applications (e.g., key generation, secure boot, post-quantum comms, etc).

---

##  Architecture

![image](https://github.com/user-attachments/assets/ab804fd9-544e-4403-90e7-f77349a2b334)


---

##  Simulation

Includes fully working testbenches for:

- `trng_top.v` (Top level module of TRNG)
- `dcm_tuner.v` (FSM module)
- `metastable_core.v` (flags metastability)
- `trng_core.v` (bit collector)
- `post_process.v` (process the bits to generate 32-bit random value)
- `clk_wiz_0.v` (This is an IP for DCM)

---

