<img src="https://raw.githubusercontent.com/WieWaldi/badges/master/img/RZ-Amper_Logo_135x135.png" align="left" width="135px" height="135px" />

### motd.sh by WieWaldi
*Colorful MOTD (message of the day) written in bash. Server status at a glance.*  
[![MIT Licence](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/licence_mit.svg)](https://opensource.org/licenses/mit-license.php)
![Maintained](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/maintained_yes-green.svg)

![MOTD screenshot](https://raw.githubusercontent.com/WieWaldi/motd.sh/master/img/screenshot_1.png)

## Usage

### Running
Clone the repository:
```shell
git clone https://github.com/WieWaldi/motd.sh.git
```

Then run `motd.sh`:
```shell
./motd.sh/motd.sh
```

This runs all the scripts in `modules` directory in order, `run-parts` style, and formats the output.

If any modules are missing in your output, plese see [requirements](#requirements).

You can also pass the config file path as the script argument (see [configuration](#configuration)):
```shell
./motd.sh/motd.sh ./path/to/config.sh
```

### Running at login
One way to run it at each login is to add a line to `~/.profile` file (assuming you cloned `motd.sh` into your home directory):
```shell
~/motd.sh/motd.sh
```

If you don't want to run it in all subshells you could do something like this instead:
```shell
if [ -z "$MOTD" ]; then
    ~/motd.sh/motd.sh
    export MOTD=1
fi
```

If you use `tmux` and don't want to see the motd.sh everytime you open a new shell in `tmux`, add this to your `.tmux.conf`:
```
set-option -ga update-environment ' MOTD'
```

### Requirements
In order to run all the available modules the following programs are required:

* [`figlet`][2] - for the banner module
* [`curl`][3] - for the public IP module
* [`bc`][4] - for the uptime module
* [`fortune`][5] - for the quote module

This list excludes the obvious ones, like [`tmux`](https://github.com/tmux/tmux) for `tmux` module.

If any program requried by the given module is missing (or any other error occurs), it will fail silently, i.e. the module just won't be shown at all.


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
To add a new module you can create a new script in `modules` directory.
For the output to be properly formatted it has to use `print_columns` function from `framework.sh`, please refer to the existing modules.

Module files have to start with a two digit number followed by a hyphen. You may disable modules by simply rename the module file.

## ToDo
- [X] Add CONTRIBUTING.md file with contribution guidelines.
- [ ] Give option to disable colors (e.g. for better readability in `tmux`).
- [ ] Colorless output with `motd.sh | sed -r "s:\x1B\[[0-9;]*[mK]::g"`
- [ ] Add more modules (e.g. weather, news, etc.)

## License
Source code is licensed under the MIT License. See [LICENSE][1] for more details.

## Credits
MOTD is hugely inspired by these repos
   
   [MOTD](https://github.com/HermannBjorgvin/MOTD) by Hermann Björgvin.  
   [Fancy MOTD](https://github.com/bcyran/fancy-motd) by Bazyli Cyran.  
   [dynamic_motd](https://github.com/sstallion/dynamic_motd) - Dynamic MOTD for FreeBSD by Steve Stallion.

## Links
Some sites and projects related to FreeBSD's motd:
   [BSD Magazine](https://bsdmag.org/) - BSD related news, articles and tutorials.  
   [freebsd-dynamic-motd](https://github.com/rooty0/freebsd-dynamic-motd/blob/master/motd.sh) - Another dynamic MOTD script for FreeBSD.

[1]: https://github.com/WieWaldi/motd.sh/blob/master/LICENSE
[2]: http://www.figlet.org/
[3]: https://curl.se/
[4]: https://www.gnu.org/software/bc/
[5]: https://software.clapper.org/fortune/
