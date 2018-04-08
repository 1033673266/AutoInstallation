#!/usr/bin/env bash
cd $(dirname ${BASH_SOURCE[0]})
. ./config.sh
. ./common_fun.sh
if [[ ! $PATH =~ ${SCRIPT_FOLDER} ]];then
    PATH=$PATH:${SCRIPT_FOLDER}
    add_bashrc "PATH=\$PATH:${SCRIPT_FOLDER}"
fi
    choose_info="
*****************************************
*    Wireless BKC Auto Installation     *
*****************************************

1 Install SUT (One key to install all drivers, utilities and BKC testing tools with required patches, step1.1-1.4)
  1.1 Install RPM dependency Only
  1.2 Install ICC with licenses Only
  1.3 Install DPDK Only
  1.4 System configuration to update extlinux.conf
2 Install PKTGEN client
3 Bind Ethernet to DPDK for BKC testing
0. Exit
Input you choice:"

while [ 1 ]; do
    export ADD_PATCH=1
    read -p "$choose_info" choose
    stop_trap_signal
    case "$choose" in
        "0")
            break
            ;;
        "1")
            cd ${SCRIPT_FOLDER}
            . ./install_rpm.sh
            cd ${SCRIPT_FOLDER}
            . ./install_icc.sh
            cd ${SCRIPT_FOLDER}
            . ./install_dpdk.sh
#            cd ${SCRIPT_FOLDER}
#            . ./install_qat.sh
            cd ${SCRIPT_FOLDER}
            . ./config_env.sh
            ;;
        "1.1")
            cd ${SCRIPT_FOLDER}
            . ./install_rpm.sh
            ;;
        "1.2")
            cd ${SCRIPT_FOLDER}
            . ./install_icc.sh
            ;;
        "1.3")
            cd ${SCRIPT_FOLDER}
            . ./install_dpdk.sh
            ;;
        "1.4")
            cd ${SCRIPT_FOLDER}
            . ./config_env.sh
            ;;
        "2")
            cd ${SCRIPT_FOLDER}
            . ./install_pktgen.sh
            cd ${SCRIPT_FOLDER}
            . ./config_env.sh
            ;;
        "3")
            cd ${SCRIPT_FOLDER}
            . ./bind_port.sh
            ;;
        "*")
            echo "Your choose is not match, please try again."
    esac
    start_trap_signal
done

