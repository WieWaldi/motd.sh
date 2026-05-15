#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | ./motd.sh/motd.sh                                                          |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Message Of The Day                                            |
# |    Requires: MOTD                                                          |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 1.1                                                           |
# |     Created: 2021-03-31                                                    |
# |    Revision: 2026-05-13                                                    |
# |                                                                            |
# | Copyright © 2022 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Variables ------------------------------------------------------------+
PREFIX="/usr/local"                                                             # Set the prefix for config and modules
export PREFIX
CONFDIR="${PREFIX}/etc"
export CONFDIR
BASEDIR="${PREFIX}/share/motd.sh"
export BASEDIR
MODULES="${BASEDIR}/modules"
export MODULES
LANG="en_US.UTF-8"                                                              # Set the locale to UTF-8
export LANG
BASE_DIR="$(dirname "$(readlink -f "${0}")")"                                   # Dir of this script
export BASE_DIR

# +----- Main -----------------------------------------------------------------+
if [ -z ${1+x} ]; then                                                          # If no config file is provided, look for one in the following order:
    CONFIG_PATH=""
    for path in \
        "${HOME}/.local/etc/motd.sh/motd.sh.conf" \
        "${CONFDIR}/motd.sh.conf" \
        "${BASEDIR}/motd.sh.conf" \
        "${BASEDIR}/config.sh"; do
        if [ -f "${path}" ]; then
            CONFIG_PATH="${path}"
            break
        fi
    done
else
    CONFIG_PATH="${1}"
fi

export CONFIG_PATH                                                              # The Framework needs the config path to be exported, so we export it here.

if [ ! -f "${CONFIG_PATH}" ]; then                                              # If no config file is found, print an error message and exit
    echo "Error: No config file found."
    echo "       You may provide one like this: ${0} /your/path/config.sh"
    exit 1
fi

if [ -z ${MOTD_FRAMEWORK+x} ]; then                                             # Find motd.sh.framework in the same way as the config file.
    MOTD_FRAMEWORK=""
    for path in \
        "${HOME}/.local/share/motd.sh/motd.sh.framework" \
        "${BASEDIR}/motd.sh.framework" \
        "${BASEDIR}/framework.sh"; do
        if [ -f "${path}" ]; then
            MOTD_FRAMEWORK="${path}"
            break
        fi
    done

    if [ -z "${MOTD_FRAMEWORK}" ]; then
        echo "Error: No motd.sh framework found."
        exit 1
    fi
fi
source "${MOTD_FRAMEWORK}"                                                      # Source the framework

get_os                                                                          # Get OS information here instead of calling uname several times.
case ${os} in                                                                   # Get our goods together
    Linux*)
    export awk="awk"
    export bc="bc"
    export grep="/usr/bin/grep"
    export sed="sed"
    export sort="/usr/bin/sort"
    ;;

    FreeBSD)
    export awk="awk"
    export bc="bc"
    export grep="/usr/bin/grep"
    export sed="sed"
    export sort="/usr/bin/sort"
    ;;

    SunOS)
    export awk="gawk"
    export bc="gbc"
    export grep="/usr/bin/grep"
    export sed="gsed"
    export sort="/usr/bin/sort"
    ;;
esac


output=""                                                                       # Run the modules and collect output
module_list=$(                                                                  # Get the list of modules to run. Modules must be placed in ./modules/
    find "${MODULES}" -maxdepth 1 -type f \
        | ${grep} -E '.*/[0-9]{2}-.*' \
        | ${sed} 's|.*/||' \
        | ${sort} -V
)

# echo "PREFIX:               ${PREFIX}"                                        # Just for debugging purposes, print the variables we have set so far. You can remove this in production.
# echo "BASEDIR:              ${BASEDIR}"
# echo "CONFDIR:              ${CONFDIR}"
# echo "MODULES:              ${MODULES}"
# echo "CONFIG_PATH:          ${CONFIG_PATH}"
# echo "MOTD_FRAMEWORK:       ${MOTD_FRAMEWORK}"
# echo "module_list:          ${module_list}"

while read -r module; do
    if ! module_output=$("${MODULES}/${module}" 2> /dev/null); then continue; fi
    output+="${module_output}"
    [[ -n "${module_output}" ]] && output+=$'\n'
done <<< "${module_list}"


columnize "${output}" $'\t' $'\n'                                               # Print the output in pretty columns
# +----- End ------------------------------------------------------------------+
