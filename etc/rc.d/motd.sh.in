#!/bin/sh
#
# +----------------------------------------------------------------------------+
# | /rc.d/motd.sh                                                              |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Example script to show off how bash_framework.sh works        |
# |    Requires: bash_framework.sh                                             |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 3                                                             |
# |     Created: 10.08.2022                                                    |
# |    Revision: ---                                                           |
# |                                                                            |
# | Copyright © 2022 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+
#

# PROVIDE: motd.sh
# REQUIRE: FILESYSTEMS mountcritremote
# BEFORE: LOGIN

. /etc/rc.subr

name="motd.sh"
desc="Colorful motd written in bash. Server status at a glance."
rcvar="update_motdsh"
config_files="${@@PREFIX@@}/etc/motd.sh.conf"
required_files="${config_files}"
command="@@PREFIX@@/libexec/${name}"
command_interpreter="/bin/sh"
start_cmd="motdsh_start"
start_precmd="${name}_prestart"
stop_cmd=":"

# set_rcvar dynamic_motd "NO"
# set_rcvar motd_script "@@PREFIX@@/etc/rc.motd"

motdsh_prestart()
{
    if ! [ "${_rc_prefix}" = "one" -o -n "${rc_fast}" -o -n "${rc_force}" ]; then
        checkyesno update_motd &&
            err 1 "Set update_motd to NO in /etc/rc.conf."
    fi
    return 0
}
motdsh_start()
{
    startmsg -n 'Starting ${name} '
    ${command}
    startmsg '.'
}

load_rc_config $name
run_rc_command "$1"

# +----------------------------------------------------------------------------+
