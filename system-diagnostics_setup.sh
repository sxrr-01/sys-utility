#!/usr/bin/env bash

read -p "Do you want to Install system-diagnostics? [Y/n] " -n 1 -r </dev/tty
echo

if [[ -z "$REPLY" || "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Installing..."
else
    echo "Aborting Installation."
    exit 1
fi

TARGET_DIR="$HOME/sys-utility"

if [ -d "$TARGET_DIR" ]; then
    echo "This Package Already Exists" >&2

    read -p "Do you want to proceed anyway? [y/N]: " REPLY </dev/tty

    REPLY=${REPLY:-N}

    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Re-Installing..."
        rm -rf "$TARGET_DIR"
        sed -i '/sys-utility/d' "$HOME/.bashrc"
        sed -i '/bashedit/d' "$HOME/.bashrc"
    else
        echo "Aborting Installation." >&2
        exit 1
    fi
fi

mkdir ~/sys-utility
touch ~/sys-utility/system-diagnostics.sh
touch ~/sys-utility/power.sh
touch ~/sys-utility/unins_sysutil.sh
touch ~/sys-utility/plasmarestart.sh

cat << 'EOF' >> ~/sys-utility/system-diagnostics.sh
echo "[Storage]" > ~/sys-utility/an-out.txt
lsblk -f >> ~/sys-utility/an-out.txt

echo -e "\n[Critical Chain]" >> ~/sys-utility/an-out.txt
systemd-analyze critical-chain >> ~/sys-utility/an-out.txt

echo -e "\n[Blame]" >> ~/sys-utility/an-out.txt
systemd-analyze blame >> ~/sys-utility/an-out.txt

echo "Output Written to: ~/sys-utility/an-out.txt"
EOF

cat << 'EOF' >> ~/sys-utility/power.sh
voltage_now=$(cat /sys/class/power_supply/ucsi-source-psy-USBC000:002/voltage_now)
current_now=$(cat /sys/class/power_supply/ucsi-source-psy-USBC000:002/current_now)

voltage_now2=$((voltage_now / 1000000))
current_now2=$((current_now / 1000000))
wattage2=$(( (voltage_now * current_now) / 1000000000000 ))

echo "Voltage: ${voltage_now2}V Current: ${current_now2}A Wattage: ${wattage2}W"
EOF

cat << 'EOF' >> ~/sys-utility/unins_sysdiag.sh
read -p "Do you want to Uninstall system-utility? [Y/n] " -n 1 -r </dev/tty
echo

if [[ -z "$REPLY" || "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Uninstalling..."
else
    echo "Aborting"
    exit 1
fi

rm -rf ~/sys-utility
sed -i '/sys-utility/d' ~/.bashrc
sed -i '/bashedit/d' ~/.bashrc
source ~/.bashrc
EOF

cat << 'EOF' >> ~/sys-utility/plasmarestart.sh
plasmashell --replace > /dev/null & disown
EOF

chmod +x ~/sys-utility/system-diagnostics.sh
chmod +x ~/sys-utility/power.sh
chmod +x ~/sys-utility/unins_sysutil.sh
chmod +x ~/sys-utility/plasmarestart.sh

echo "alias system-diagnostics='~/sys-utility/system-diagnostics.sh'" >> ~/.bashrc
echo "alias whatpower='~/sys-utility/power.sh'" >> ~/.bashrc
echo "alias bashedit='nano ~/.bashrc'" >> ~/.bashrc
echo "alias uninstall-sys-utility='~/sys-utility/unins_sysdiag.sh'" >> ~/.bashrc
echo "alias plasmarestart='~/sys-utility/plasmarestart.sh'" >> ~/.bashrc
source ~/.bashrc

TARGET_DIR="$HOME/sys-utility"

if [ -d "$TARGET_DIR" ]; then
    echo -e "
    Utility Package Installed Successfully \n
    Added Commands & Functionality:
        Run 'system-diagnostics' to Run a quick Boot Time & Storage Overview. Output will be written to: ~/sys-utility/an-out.txt
        Run 'whatpower' to get current Input Voltage, Current and Wattage
        Run 'bashedit' for quick ~/.bashrc access
        Run 'plasmarestart' to restart Plasmashell in Case of Hangups / Crashes (May close Running Programs!)
        Run 'setpower' to choose between Performance (1) and Power Save (0) \n
    To Uninstall this Package, Run 'uninstall-sys-utility' \n
    Please reload your Shell or run 'source ~/.bashrc' for all Changes to take Effect
    "
    else
        echo "The Package was not Installed Successfully"
        rm -rf ~/sys-utility
        sed -i '/sys-utility/d' ~/.bashrc
        sed -i '/bashedit/d' ~/.bashrc
fi



