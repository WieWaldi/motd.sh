# motd.sh
*Colorful MOTD (message of the day) written in bash. Server status at a glance.*  
[![MIT Licence](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/licence_mit.svg)](https://opensource.org/licenses/mit-license.php)
![Maintained](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/maintained_yes-green.svg)

![motd.sh screenshot](https://raw.githubusercontent.com/WieWaldi/motd.sh/master/img/screenshot_1.png)

## Directories
Just for convenience, here is the directory structure of the project:
```shell
/usr/local
├── bin
│   └── motd.sh
├── etc
│   ├── motd.sh.conf
│   └── rc.d
│       └── motd.sh
├── libexec
│   ├── motd.sh
│   └── motd.sh.framework
└── share
    ├── doc
    │   └── motd.sh
    │       ├── CONTRIBUTING.md
    │       ├── LICENSE
    │       ├── LICENSE_BSD
    │       ├── LICENSE_MIT
    │       └── README.md
    └── motd.sh
        └── modules
            ├── 00-atest
            ├── 00-banner
            ├── 00-datetime
            ├── 10-user
            ├── 11-os
            ├── 12-ip
            ├── 13-public-ip
            ├── 20-uptime
            ├── 30-load
            ├── 31-memory
            ├── 32-disk
            ├── 33-services
            ├── 34-cert
            ├── 34-docker
            ├── 35-temperatures
            ├── 36-smart
            ├── 40-tmux
            ├── 41-updates
            ├── 50-quote
            └── 60-weather

```
