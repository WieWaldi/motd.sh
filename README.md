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

* [`figlet`](http://www.figlet.org/)
* [`curl`](https://curl.se/)
* [`bc`](https://www.gnu.org/software/bc/)
* [`fortune`](https://software.clapper.org/fortune/)

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

## Credits
MOTD is hugely inspired by these repos
   
   [MOTD](https://github.com/HermannBjorgvin/MOTD) by Hermann Björgvin.  
   [Fancy MOTD](https://github.com/bcyran/fancy-motd) by Bazyli Cyran.  
