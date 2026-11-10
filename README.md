# System-Utility

# What is sys-utility?
* **Quick System Diagnostic & Utility Commands for systemd based Linux Systems**
* **works with bash**
* **Easy Install and Uninstall**

## Installation

1. **Get & Execute Install Script (Paste into your Bash Shell)**
   ```bash
   curl -fsSL https://raw.githubusercontent.com/sxrr-01/sys-utility/main/system-diagnostics_setup.sh | bash
   ```
2. **Follow the singular install Prompt & Read the Instructions**

3. **Reload your Shell or run 'source ~/.bashrc' for all Changes to take Effect**

## How to Use

**All of these Instructions can be found in the Post-Install Prompt**

* **Run 'system-diagnostics' to Run a quick Boot Time & Storage Overview. Output will be written to: ~/sys-utility/an-out.txt**
   ```bash
   system-diagnostics
   ```
* **Run 'whatpower' to get current Input Voltage, Current and Wattage**
   ```bash
   whatpower
   ```
   Experimental, Only Tested on Lenovo Yoga X1 Gen 3
   
* **Run 'bashedit' for quick ~/.bashrc access**
   ```bash
   bashedit
   ```
* **Run 'plasmarestart' to restart Plasmashell in Case of Hangups / Crashes (May close Running Programs!)**
   ```bash
   plasmarestart
   ```
* **Run 'setpower' to choose between Performance (1) and Power Save (0). Requires sudo**
   ```bash
   setpower
   ```
   Experimental, Intel CPUs Only for Now
   
* **Run 'uninstall-sys-utility' to Uninstall this Package**
   ```bash
   uninstall-sys-utility
   ```

## That's It!

Feel Free to do whatever you want with this Code

