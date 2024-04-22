# PhysiCell2024

This is an update to the original model used in the pre-print. 

Cell density couples tissue mechanics to control the elongation speed of the body axis.
 Changqing Lu,  Joana M. N. Vidigueira,  Christopher Chan Jin Jie,  Alicja Maksymiuk,  Fengzhu Xiong, https://doi.org/10.1101/2023.12.31.573670

Randy Rheiland assisted with this update.
View comments on the old model at https://github.com/rheiland/tissue_elongation

This new version 
* uses PhysiCell 1.13.1 
* uses PhysiCell Studio
* uses `config/body_cells.csv` for the initial conditions of the cells
* uses `config/body_rules.csv` to specify cell rules that prevent unrealistic overcrowding
* most of the original parameters are retained. As before, this is a minimal model where information about proliferation, apoptosis and the substrate has been excluded.
  
The model can be modified on PhysiCell Studio, more parameters can be easily added.
To do so:
* download a copy of PhysiCell3D model repo
* set up PhysiCell https://github.com/physicell-training/ws2023/blob/main/agenda.md
* run `make` in the root directory to build the `bodyaxis` executable model
* get the latest release of PhysiCell Studio (rf. https://github.com/PhysiCell-Tools/Studio-Guide) and run it with this model, e.g.,

run `python studio/bin/studio.py -c config/body_axis3D.xml -e bodyaxis -3` in the root directory

Parameters can be added/modified in the 'Cell Types' tab
<img width="1083" alt="image" src="https://github.com/ChrisChanJ/PhysiCell2024/assets/82984556/5f60202c-1582-40f0-bbbf-65af0b97e4a0">

Run Simulation
<img width="1087" alt="image" src="https://github.com/ChrisChanJ/PhysiCell2024/assets/82984556/7f3a2a2c-314e-4bdd-b613-01fe4e5266d1">

Plot
<img width="1089" alt="image" src="https://github.com/ChrisChanJ/PhysiCell2024/assets/82984556/f3ffd882-b798-45ed-86b8-54f1d3ff6419">






