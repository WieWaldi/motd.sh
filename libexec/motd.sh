# /bin/sh
# +----------------------------------------------------------------------------+
# | ./motd.sh/                                                                 |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Colorful motd written in bash. Server status at a glance.     |
# |    Requires: ---                                                           |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 1.0                                                           |
# |     Created: 2021-03-31                                                    |
# |    Revision: 2026-05-13                                                    |
# |                                                                            |
# | Copyright © 2021 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

motd_script="/usr/local/bin/motd.sh"
motd_config="/usr/local/etc/motd.sh.conf"
motd_file="/var/run/motd"
motd_template="/etc/motd.template"
motd_perms="644"

# Remove existing motd before creating fifo:
rm -f "${motd_file}"

mkfifo -m $motd_perms "${motd_file}" || exit 1
(
    # Care should be taken to remove the fifo when not in use to prevent
    # hangs on login. Woe be to the one who issues SIGKILL:
    trap "rm -f ${motd_file}; exit" HUP INT QUIT TERM

    while true; do
        # Execute script in the background to quiesce job control
        # messages when the service is stopped:
        env -i sh "${motd_script}" "${motd_config} > "${motd_template}"
        cat "${motd_template}" > "${motd_file}" 2>&1 &
        wait 2>/dev/null
    done
) &
