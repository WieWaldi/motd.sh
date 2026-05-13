#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | setup.sh                                                                   |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Setup Script to install motd.sh into /usr/local               |
# |    Requires: GNU core utils                                                |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 0.1                                                           |
# |     Created: 29.09.2023                                                    |
# |    Revision: ---                                                           |
# |                                                                            |
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Include bash-framework.sh --------------------------------------------+
# set -o errexit
# set -o pipefail
export BASH_FRMWRK_MINVER=4
export LANG="en_US.UTF-8"
export base_dir="$(dirname "$(readlink -f "$0")")"
export cdir=$(pwd)
export scriptname="${BASH_SOURCE##*/}"
export scriptdir="${BASH_SOURCE%/*}"
export datetime="$(date "+%Y-%m-%d-%H-%M-%S")"
export logfile="${scriptdir}/${datetime}.log"
export framework_width=80

if [[ -f "${scriptdir}"/bash-framework.sh ]]; then
    BASH_FRMWRK_FILE="${scriptdir}/bash-framework.sh"
else
    test_file=$(which bash-framework.sh 2>/dev/null)
    if [[ $? = 0 ]]; then
        BASH_FRMWRK_FILE="${test_file}"
        unset test_file
    else
        echo -e "\nNo Bash Framework found.\n"
        exit 1
    fi
fi

source "${BASH_FRMWRK_FILE}"
if [[ "${BASH_FRMWRK_VER}" -lt "${BASH_FRMWRK_MINVER}" ]]; then
    echo -e "\nI've found version ${BASH_FRMWRK_VER} of bash_framework.sh, but I'm in need of version ${BASH_FRMWRK_MINVER}."
    echo -e "You may get the newest version from https://github.com/WieWaldi/bash-framework.sh\n"
    exit 1
fi

# +----- Variables ------------------------------------------------------------+
PREFIX="/usr/local"
CONFDIR="${PREFIX}/etc"
BASEDIR="${PREFIX}/share/motd.sh"
MODULES="${PREFIX}/share/motd.sh/modules"


# +----- Main -----------------------------------------------------------------+
clear
__display_Text_File blue ${cdir}/setup-notice.txt
if [[ "$(__read_Antwoord_YN "Do you want to proceed?")" = "no" ]]; then
    echo -e "\n Oh Boy, you should reconsider your decision."
    exit 1
fi

__echo_Left "Make Diretory: ${PREFIX}/bin"
mkdir -p ${PREFIX}/bin >> /dev/null 2>&1
__echo_Result

__echo_Left "Make Diretory: ${CONFDIR}"
mkdir -p ${CONFDIR} >> /dev/null 2>&1
__echo_Result

__echo_Left "Make Base Directory: ${BASEDIR}"
mkdir -p ${BASEDIR} >> /dev/null 2>&1
__echo_Result

__echo_Left "Make Diretory: ${MODULES}"
mkdir -p ${MODULES} >> /dev/null 2>&1
__echo_Result

__echo_Left "Installing executable file to ${PREFIX}/bin"
cp -rf motd.sh ${PREFIX}/bin >> /dev/null 2>&1
__echo_Result
chmod 755 ${PREFIX}/bin/motd.sh >> /dev/null 2>&1

__echo_Left "Installing configuration file to ${CONFDIR}"
cp -rf motd.sh.conf ${CONFDIR} >> /dev/null 2>&1
__echo_Result

__echo_Left "Installing base files to ${BASEDIR}"
cp -rf framework.sh ${BASEDIR} >> /dev/null 2>&1
__echo_Result

__echo_Left "Installing LICENSE to ${BASEDIR}"
cp -rf LICENSE ${BASEDIR} >> /dev/null 2>&1
__echo_Result

__echo_Left "Installing README.md to ${BASEDIR}"
cp -rf README.md ${BASEDIR} >> /dev/null 2>&1
__echo_Result

__echo_Left "Installing modules to ${MODULES}"
cp -rf modules/* ${MODULES} >> /dev/null 2>&1
__echo_Result

__echo_Title "I'm done."
echo -e "\n\n"
exit 0
# +----- End ------------------------------------------------------------------+
