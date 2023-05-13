# Circuit design
## Hardware
This module is to design the pulse emission, system control and signal processing circuit. And finally what I expected to make is an integration pcb, like the AFE module sold on ADI.
After reading lots of papers and researching Kleu's ultrasound projects and some patents, I completed the following works, Version1.0 and Version2.0. Still struggling with the layout of Version 2.0 (On May 4th:joy:, also inspired an idea of designing an auto-layout software).

### Version1.0(Wasted)
My first design of the control circuit mainly contains the following blocks, and you could search online for details information on components in the sch. In my vesion1.0, you could see the absence of SRAM, though I designed it in the sch, I gave it up since it was hard to layout such many nets. And vesion1.0 could be seen as a complete failure, though it help me accumulate enough experience to carry on the vesion2.0 plan.

![PCB-Version1.0](/01_Circuit-design/Hardware/Version1.0/pic/Pcb-version1.0_function.png)


### Version2.0(Ongoing)
In Version 2.0, I use FPGA XC6SLX9-2TQG144C to control all the components including ADC, VGA, DAC, etc. However, I'm not sure whether it could function well and I just interface all the parts with the FPGA. Finally, I finished Version 2.0's schematic and continue working on the PCB design. Although the schematic looks simple and my work seems little, it's what a torture when you are faced with all the components' selection, interfacing and so on. It's not the perfect work I expected. Maybe Version 3.0, 4.0 will solve the remaining problems and have a good ending. Back to now, I will struggle with Vesion2.0's PCB layout purchase the components, complete the SMT and have a board test. It will consume me several months since the study, internship program etc. And keep this project going!

![SCH-Version2.0](/01_Circuit-design/Hardware/Version2.0/Pics/Sch-vesion2.0(complete)_00.png)

### Remain works & Problems & Information
**Remain works**
- [ ] Complete the Vesion2.0's PCB design
- [ ] Prepare the BOM
- [ ] SMT
- [ ] Experienmnt

**Problems**
- AGND, DGND, AVCC, DVCC
- EMI & CLOCK
- Impedance matching of high-speed circuits
- Packages of resistances, inductance, capacitance

**Information**
- Softwares used: Easy-eda, Kicad, Free-routing

## Emulation
## Experiment
## Reference

