# motd.sh
*Colorful MOTD (message of the day) written in bash. Server status at a glance.*  
[![MIT Licence](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/licence_mit.svg)](https://opensource.org/licenses/mit-license.php)
![Maintained](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/maintained_yes-green.svg)

![motd.sh screenshot](https://raw.githubusercontent.com/WieWaldi/motd.sh/master/img/screenshot_1.png)

## Installation
Preferred method to get started is by [forking][6] this repository on GitHub
and clone it. You may download one of the [releases][4] as well.

```shell
$ git clone git@github.com:WieWaldi/motd.sh.git
$ sudo motd.sh/setup.sh
```
The setup script will put motd.sh into it's default location. Don't
worry, you'll be fine. The default location is `/usr/local`.
If you don't like that you may run motd.sh right out of this directory or 
tinker around and place it where you like it

If you're using make, you'll have two options to define the installation
target. You can either set the `PREFIX` variable in `config.mk` or
pass it to `make` command. Just `make` will print all variables used 
in the Makefile.
```shell
# export DESTDIR=`mktemp -d`
# make install
```

## Usage

### Running
Simply by running it.
```shell
$ motd.sh
```
This runs all the scripts in `modules` directory in order, `run-parts` style,
and formats the output. If any modules are missing in your output, plese see 
[requirements](#Requirements). You can also pass the config file path as the
script argument (see [configuration](#Configuration)):
```shell
$ /usr/local/bin/motd.sh /usr/local/etc/motd.sh
```

### Running at login
One way to run it at each login is to add a line to `~/.profile` file (assuming
you cloned `motd.sh` into your home directory):
```shell
~/motd.sh/motd.sh
```

If you don't want to run it in all subshells you could do something like this
instead:
```shell
if [ -z "${motdsh}" ]; then
    ~/motd.sh/motd.sh
    export motdsh=1
fi
```

If you use `tmux` and don't want to see the motd.sh everytime you open a new
shell in `tmux`, add this to your `.tmux.conf`:
```
set-option -ga update-environment ' motdsh'
```

### Requirements
In order to run all the available modules the following programs are required:

* [`coreutils`][14] - for basic commands like `date`, `uptime`, `df`, etc.
* [`figlet`][10] - for the banner module
* [`curl`][11] - for the public IP module
* [`bc`][12] - for the uptime module
* [`fortune`][13] - for the quote module

This list excludes the obvious ones, like [`tmux`][15]
for `tmux` module. If any program requried by the given module is missing 
(or any other error occurs), it will fail silently, i.e. the module just won't
be shown at all.


### Configuration
You can configure some aspects of the motd.sh using config file.
By default `config.sh` file in the `motd.sh` directory will be read if it exists.
Alternatively you can pass path to another config as a script argument.

There's an example file provided in the repo:
```shell
cd motd.sh
cp config.sh.example config.sh
```

## Hacking
To add a new module you can create a new script in `modules` directory. For the 
output to be properly formatted it has to use `print_columns` function from
`framework.sh`, please refer to the existing modules.

Module files have to start with a two digit number followed by a hyphen.
You may disable modules by simply rename the module file.
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
## ToDo
- [X] Add CONTRIBUTING.md file with contribution guidelines.  
- [ ] Give option to disable colors (e.g. for better readability in `tmux`).  
- [ ] Colorless output with `motd.sh | sed -r "s:\x1B\[[0-9;]*[mK]::g"`  
- [ ] Add more modules (e.g. weather, news, etc.)  

## License
Source code is licensed under the MIT License. See [LICENSE][1] for more details.
Some parts of the code have been published under the BSD-2-Clause License,
see the respective files for details.

## Credits
motd.sh is hugely inspired by these repos  
   [MOTD](https://github.com/HermannBjorgvin/MOTD) by Hermann Björgvin - Fun MOTD (message of the day) for your homelab server  
   [Fancy MOTD](https://github.com/bcyran/fancy-motd) by Bazyli Cyran - Fancy, colorful MOTD written in bash. Server status at a glance.  
   [dynamic_motd](https://github.com/sstallion/dynamic_motd) by Steve Stallion - Dynamic messages of the day on FreeBSD 13.0 or later  

## Links
Some sites and projects related to FreeBSD's motd:  
   [BSD Magazine](https://bsdmag.org/) - BSD related news, articles and tutorials.  
   [freebsd-dynamic-motd](https://github.com/rooty0/freebsd-dynamic-motd/blob/master/motd.sh) - Another dynamic MOTD script for FreeBSD.  

[1]: https://github.com/WieWaldi/motd.sh
[2]: https://github.com/WieWaldi/motd.sh/wiki
[3]: https://github.com/WieWaldi/motd.sh/issues
[4]: https://github.com/WieWaldi/motd.sh/releases
[5]: https://github.com/WieWaldi/motd.sh/blob/master/LICENSE
[6]: https://docs.github.com/en/github/getting-started-with-github/fork-a-repo
[7]: https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request
[10]: http://www.figlet.org/
[11]: https://curl.se/
[12]: https://www.gnu.org/software/bc/
[13]: https://software.clapper.org/fortune/
[14]: https://www.gnu.org/software/coreutils/
[15]: https://github.com/tmux/tmux
