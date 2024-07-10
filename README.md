# AEM-Lk
## Automation of Kinetic Inductance Extraction of MKID Simulations.

# **This is the old version of AEM Lk and my contain many bugs, errors and crashes. Please see AEM Lk v2 for an updated version of the code**




This app allows the __automation of kinetic inductance__ value from Sonnet geometry files based on measured resonant frequencies.  

This app is primarily focused towards **prototyping MKIDs**.    

Kinetic Inductance is an important variable in fabricating MKIDs and extraction of accurate Lk values are important for the reproducibility of MKIDs.  

AEM-Lk was developed to automate the parameterization of the kinetic inductance value in Sonnet to match measured resonant frequencies of MKID pixels.  

The installer file above will install AEM-Lk as an app on your MatLab GUI under **"Apps"**.  

AEM-Lk takes in a single .txt file containing the file names of the original MKID geometry Sonnet files and the corresponding measured resonant frequencies. The txt file should look as follows:  


![txtfile](https://github.com/scathalmca/AEM-Lk/assets/92909628/22976773-c246-4f27-8f15-710388fc0cf1)

Once the file is uploaded, choose the **accuracy** of the kinetic inductance value from the following options:  

**1 pH/sq**.  

**0.1 pH/sq**. 

**0.01 pH/sq**. 

**0.001 pH/sq**. 

The script will then simulate each original Sonnet file and begin adjusting the kinetic inductance value of each to match measured resonant frequencies.  
Make sure the original Sonnet geometry files are in your current path in Matlab.


<img width="498" alt="AEMLKGUI" src="https://github.com/scathalmca/AEM-Lk/assets/92909628/e65fb3dc-20e8-4830-a4d6-30b5bbd0b54d">

The script will output a text file called "Kinetic Inductance Data.txt" containing:  


**Runtime of Automation:**  

**Number of Simulations Performed:**

**Accuracy of Lk**


**Mean Lk:**  

**Lk standard deviation:**  

**Filenames of new geometry files with corrected Lk:**  

**Measured resonant frequencies:**  

**Simulated Corrected resonant frequencies:**  

**Lk Values:** 

**Simulated Corrected $Q_{C}$:**  



