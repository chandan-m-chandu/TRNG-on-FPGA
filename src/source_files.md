# SOURCE FILES

- `trng_top.v` (Top level module of TRNG)
- `dcm_tuner.v` (FSM module)
- `metastable_core.v` (flags metastability)
  > This instantiates a CARRY4 hardware primitive inbuilt logic from Xilinx-AMD for FPGAs. It enhances the randomness of the bits.
- `trng_core.v` (bit collector)
- `post_process.v` (process the bits to generate 32-bit random value)
- `clk_wiz_0.v` (This is an IP for DCM)
  > *clk_wiz_0* is an IP, which can be added/customized to the project directory via IP Catalog. This is not nessarily a verilog code to be manually coded.
  > Make sure to enable the *Dynamic phase shift* to the clock in IP customization.
  > ![Screenshot 2025-06-12 194631](https://github.com/user-attachments/assets/8108c5d9-33ba-43c4-9bf6-5fd6ac8003da)
 
---
