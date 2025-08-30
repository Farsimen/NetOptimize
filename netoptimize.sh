#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Run as root!"
    exit 1
fi

main_menu() {
    clear
    echo "----- NetOptimize -----"
    echo "بهینه‌سازی شبکه با tc"
    echo "-----------------------"
    echo "1. نصب و اعمال بهینه‌سازی"
    echo "2. سفارشی‌سازی (تغییر BANDWIDTH/RTT)"
    echo "3. پاک کردن کامل (حذف همه تنظیمات)"
    echo "4. خروج"
    read -p "انتخاب: " choice
    case $choice in
        1) install_optimize ;;
        2) customize ;;
        3) clean_all ;;
        4) exit 0 ;;
        *) main_menu ;;
    esac
}

install_optimize() {
    cat > /usr/local/bin/tc_optimize.sh << 'EOF'
#!/bin/bash
INTERFACE=$(ip route get 8.8.8.8 | awk '/dev/ {print $5; exit}')
if [ -z "$INTERFACE" ]; then
    echo "ERROR: Could not detect network interface." >&2
    exit 1
fi
LOG_FILE="/var/log/tc_smart.log"
echo "$(date): Starting network optimization on $INTERFACE" >> "$LOG_FILE"
EXISTING_QDISC=$(tc qdisc show dev $INTERFACE | grep -E 'cake|fq_codel|htb|netem')
if [ ! -z "$EXISTING_QDISC" ]; then
    echo "$(date): Existing qdiscs found, deleting..." >> "$LOG_FILE"
    tc qdisc del dev $INTERFACE root 2>> "$LOG_FILE"
    tc qdisc del dev $INTERFACE ingress 2>> "$LOG_FILE"
fi
ip link set dev $INTERFACE mtu 1500 2>> "$LOG_FILE"
echo 1000 > /sys/class/net/$INTERFACE/tx_queue_len 2>> "$LOG_FILE"
BANDWIDTH="1000mbit"
RTT="20ms"
if tc qdisc add dev $INTERFACE root cake bandwidth $BANDWIDTH rtt $RTT nat dual-dsthost 2>> "$LOG_FILE"; then
    echo "$(date): CAKE optimization complete" >> "$LOG_FILE"
    echo "CAKE optimization complete"
elif tc qdisc add dev $INTERFACE root fq_codel limit 10240 flows 1024 target 5ms interval 100ms 2>> "$LOG_FILE"; then
    echo "$(date): FQ_CoDel optimization complete" >> "$LOG_FILE"
    echo "FQ_CoDel optimization complete"
elif tc qdisc add dev $INTERFACE root handle 1: htb default 11 2>> "$LOG_FILE" && \
     tc class add dev $INTERFACE parent 1: classid 1:1 htb rate $BANDWIDTH ceil $BANDWIDTH 2>> "$LOG_FILE" && \
     tc class add dev $INTERFACE parent 1:1 classid 1:11 htb rate $BANDWIDTH ceil $BANDWIDTH 2>> "$LOG_FILE" && \
     tc qdisc add dev $INTERFACE parent 1:11 netem delay 1ms loss 0.005% duplicate 0.05% reorder 0.5% 2>> "$LOG_FILE"; then
    echo "$(date): HTB+Netem optimization complete" >> "$LOG_FILE"
    echo "HTB+Netem optimization complete"
else
    tc qdisc add dev $INTERFACE root netem delay 1ms loss 0.005% duplicate 0.05% reorder 0.5% 2>> "$LOG_FILE"
    echo "$(date): Fallback Netem optimization complete" >> "$LOG_FILE"
    echo "Fallback Netem optimization complete"
fi
tc qdisc show dev $INTERFACE | grep -E 'cake|fq_codel|htb|netem'
echo "$(date): Network optimization finished." >> "$LOG_FILE"
EOF
    chmod +x /usr/local/bin/tc_optimize.sh
    (crontab -l 2>/dev/null; echo "@reboot sleep 30 && /usr/local/bin/tc_optimize.sh") | crontab -
    /usr/local/bin/tc_optimize.sh && echo "بهینه‌سازی اعمال شد"
    main_menu
}

customize() {
    clear
    read -p "BANDWIDTH جدید (مثل 1000mbit): " new_bandwidth
    read -p "RTT جدید (مثل 20ms): " new_rtt
    sed -i "s/BANDWIDTH=\".*\"/BANDWIDTH=\"$new_bandwidth\"/g" /usr/local/bin/tc_optimize.sh
    sed -i "s/RTT=\".*\"/RTT=\"$new_rtt\"/g" /usr/local/bin/tc_optimize.sh
    echo "تنظیمات بروز شد. حالا گزینه 1 رو بزنید."
    main_menu
}

clean_all() {
    INTERFACE=$(ip route get 8.8.8.8 | awk '/dev/ {print $5; exit}')
    tc qdisc del dev $INTERFACE root 2>/dev/null
    tc qdisc del dev $INTERFACE ingress 2>/dev/null
    crontab -l | grep -v "/usr/local/bin/tc_optimize.sh" | crontab -
    rm /usr/local/bin/tc_optimize.sh 2>/dev/null
    rm /var/log/tc_smart.log 2>/dev/null
    echo "همه چیز پاک شد."
    main_menu
}

main_menu
