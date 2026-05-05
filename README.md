# Development of a Combinatorial Optical Property Measuring System for Liquid Classification and Quantification

## Overview
This project presents the development of a **non-destructive combinatorial optical measurement system** designed to characterize and analyze liquid samples. The system measures key optical properties including **transmittance, absorption, refraction, and scattering** and integrates **machine learning techniques** for both classification and quantification of liquids.

---

## Objective
The main objective of this project was to:

- Develop a **single optical instrument** capable of measuring multiple optical properties simultaneously  
- Use **multi wavelength LEDs (visible range)** and photodetectors for data acquisition  
- Apply **data compression and multivariate analysis techniques**  
- Train the system using **machine learning methods** to:
  - Quantify liquid concentrations  
  - Classify different liquid types  

---

## System Design

### Optical Design
- **Light Sources:** LEDs with wavelengths ranging from **375 nm to 810 nm**
- **Detector:** Hamamatsu S5971 photodiode  
- **Sample Holder:** Quartz tube (high transmittance over a wide spectral range)
- **Configuration:**
  - LEDs and photodiodes arranged to measure:
    - **Transmittance (180° configuration)**
    - **Scattering (90° configuration)**

---

### Electronic Design
- Photodiode output converted using a **transimpedance amplifier**
- LEDs driven using **constant current sources**
- **Control System:** Arduino Nano microcontroller
- **Data Acquisition:**
  - NI-USB6009 DAQ card  
  - 14-bit ADC  

---

### 💻 Software & Data Acquisition
- Custom software used to:
  - Control LED switching via microcontroller  
  - Acquire continuous data from DAQ system  
- Data stored in **binary format**
- Each sample measurement completed within **15 seconds**

---

## Experimental Data

### Liquids Used

#### Non scattering solutions:
- Potassium dichromate (K₂Cr₂O₇)  
- Potassium permanganate (KMnO₄)  
- Copper sulphate (CuSO₄)  
- Cobalt(II) acetate tetrahydrate (Co(CH₃COO)₂·4H₂O)  

#### Scattering solution:
- Milk  

### Additional Experiments
- Liquid mixtures:
  - KMnO₄ mixed with NaOH (base solution)
- Dilution series created for all liquids to analyze concentration variation

---

## Data Processing & Analysis

### Data Compression
- **Singular Value Decomposition (SVD)** used to:
  - Reduce dimensionality  
  - Retain dominant features of the dataset  

---

### Quantification (Supervised Learning)
- A **matrix based statistical model** was developed  
- Model trained using known concentration values  
- Performance evaluated using:
  - Correlation analysis  
  - Residual plots  

---

### Classification (Unsupervised Learning  Approach I)
- **Principal Component Analysis (PCA)**  
- **Hierarchical Clustering (Dendrograms)**  
- Used to:
  - Classify different liquids  
  - Separate scattering vs non scattering samples  

---

### Classification (Neural Network – Approach II)
- Multi-layer Artificial Neural Network:
  - Input layer, hidden layers, and output layer  
  - Activation functions: **ReLU** and **Softmax**
- Data split:
  - 70% training  
  - 15% validation  
  - 15% testing  
- Input features include **both transmittance and scattering data**

---

## Results

### Quantification Performance
Strong correlation between predicted and actual concentrations:

- KMnO₄: 0.99  
- CuSO₄: 0.99  
- Co(CH₃COO)₂·4H₂O: 0.97  
- K₂Cr₂O₇: 0.85  
- Milk: 0.87  

Residual analysis showed errors centered around zero, indicating a good model fit.

---

### Classification Performance

#### Neural Network:
- **Validation Accuracy:** 91.86%

#### Confusion Matrix Metrics:
- **Specificity:** 1.00 (all liquids)  
- **Precision:** 1.00 (all liquids)  

Sensitivity & Accuracy:
- KMnO₄: 0.94 / 0.99  
- CuSO₄: 0.93 / 0.98  
- Co(CH₃COO)₂·4H₂O: 0.93 / 0.98  
- K₂Cr₂O₇: 0.70 / 0.95  
- Milk: 1.00 / 1.00  

---

## Key Features
- Non destructive liquid analysis  
- Simultaneous measurement of multiple optical properties  
- Rapid measurement (~15 seconds per sample)  
- Works for both **scattering and non scattering liquids**  
- Capable of:
  - Concentration prediction  
  - Liquid classification  
  - Identifying liquids in mixtures  

---

## Applications
- Chemical analysis  
- Industrial liquid monitoring  
- Non destructive testing  
- Optical sensing research  

---

## Methods Used
- Optical spectroscopy  
- Singular Value Decomposition (SVD)  
- Principal Component Analysis (PCA)  
- Hierarchical clustering  
- Artificial Neural Networks

---

```markdown  
optical-ml-liquid-classifier/
│
├── README.md
├── requirements.txt  
│
├── data_analysis_quantification/
│   └── quantification_of_liquids.mat
│
├── classification_liquids/
│   ├── classification_PCA.m
│   ├── classification_hierachical_clustering.m
│
├── neural_network_model/
│   ├── cnn_model.py
│
```
---
## Contact

**Didulani Acharige**
Department of Mechanical and Materials Engineering
Western University
Email: [dsalwath@uwo.ca](mailto:dsalwath@uwo.ca)
