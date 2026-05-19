# motd.sh

*Colorful MOTD (Message of the Day) written in Bash. Server status at a glance.*  
[![MIT License](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/licence_mit.svg)](https://opensource.org/licenses/mit-license.php)  
![Maintained](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/maintained_yes-green.svg)

---

## Overview

`motd.sh` is a dynamic and customizable Message of the Day (MOTD) script written in Bash. It is designed to provide a colorful and organized display of system information at login. The script is modular, allowing users to easily add, remove, or modify modules to suit their needs.

This tool is particularly useful for FreeBSD 13.0 or later, where it can replace the default MOTD functionality with dynamic content. By leveraging a FIFO file at `/var/run/motd`, `motd.sh` can display real-time system information, updates, or other relevant data during login.

![motd.sh screenshot](https://raw.githubusercontent.com/WieWaldi/motd.sh/master/img/screenshot_1.png)

---

## Features

- **Dynamic Content**: Displays real-time system information such as uptime, disk usage, public IP, and more.
- **Customizable Modules**: Easily add or remove modules to tailor the output to your needs.
- **Colorful Output**: Provides a visually appealing and organized display.
- **FreeBSD Integration**: Works seamlessly with FreeBSD's MOTD system.
- **Silent Failures**: Modules fail gracefully if dependencies are missing.

---

## Installation

### Clone the Repository

The easiest way to get started is by forking this repository and cloning it to your local machine:

```bash
$ git clone git@github.com:WieWaldi/motd.sh.git
$ sudo motd.sh/setup.sh
```

The setup script installs `motd.sh` to its default location (`/usr/local`). If you prefer a different location, you can run the script directly from the cloned directory or modify the installation path.

### Using `make`

If you use `make`, you can define the installation target by setting the `PREFIX` variable in `config.mk` or passing it as an environment variable:

```bash
# export DESTDIR=`mktemp -d`
# make install
```

---

## Requirements

To use all available modules, the following programs are required:

- [`coreutils`](https://www.gnu.org/software/coreutils/) - Basic commands like `date`, `uptime`, `df`, etc.
- [`figlet`](http://www.figlet.org/) - For the banner module.
- [`curl`](https://curl.se/) - For the public IP module.
- [`bc`](https://www.gnu.org/software/bc/) - For the uptime module.
- [`fortune`](https://software.clapper.org/fortune/) - For the quote module.

If a required program is missing, the corresponding module will fail silently and not be displayed.

---

## Usage

### Running the Script

To run the script manually:

```bash
$ motd.sh
```

This executes all scripts in the `modules` directory in order. If any modules are missing, check the [Requirements](#requirements) section.

You can also specify a custom configuration file:

```bash
$ mkdir -p ~/.local/share/motd.sh && cp /usr/local/etc/motd.sh.conf ~/.local/share/motd.sh
$ /usr/local/bin/motd.sh ~/.local/share/motd.sh/motd.sh.conf
```

### Running at Login

To display the MOTD at every login, add the following line to your `~/.profile` or `~/.zlogin`:

```bash
/usr/local/bin/motd.sh
```

To avoid running the script in subshells, use:

```bash
if [ -z "${motdsh}" ]; then
    /usr/local/bin/motd.sh
    export motdsh=1
fi
```

For `tmux` users, to prevent the MOTD from appearing in every new shell, add this to your `.tmux.conf`:

```bash
set-option -ga update-environment ' motdsh'
```

### Running as `/etc/motd`

To use `motd.sh` as the system MOTD:

1. Disable the default MOTD update in `/etc/rc.conf`:

   ```bash
   # sysrc update_motd="NO"
   ```

2. Enable the `motd.sh` service:

   ```bash
   # sysrc motdsh="YES"
   # service motdsh start
   ```

---

## Configuration

The script looks for a configuration file (`motd.sh.conf`) in the following order:

1. `~/.local/share/motd.sh/motd.sh.conf`
2. `~/.config/motd.sh/motd.sh.conf`
3. `/usr/local/etc/motd.sh.conf`
4. `/usr/local/share/motd.sh/motd.sh.conf`

You can copy the default configuration file to a custom location and specify it as an argument:

```bash
$ mkdir -p ~/.local/share/motd.sh && cp /usr/local/etc/motd.sh.conf ~/.local/share/motd.sh
$ /usr/local/bin/motd.sh ~/.local/share/motd.sh/motd.sh.conf
```

---

## Hacking & Contributing

### Adding Modules

To create a new module, add a script to the `modules` directory. Use the `print_columns` function from `framework.sh` for proper formatting. Refer to the `00-atest` module for an example.

Module filenames should start with a two-digit number followed by a hyphen. To disable a module, simply rename the file.

### Contributing

Pull requests are welcome! For contribution guidelines, see [CONTRIBUTING.md](https://github.com/WieWaldi/motd.sh/blob/master/CONTRIBUTING.md).

---

## To-Do List

- [X] Add CONTRIBUTING.md file with contribution guidelines.
- [ ] Add an option to disable colors (e.g., for better readability in `tmux`).
- [ ] Implement colorless output using `motd.sh | sed -r "s:\x1B\[[0-9;]*[mK]::g"`.
- [ ] Add more modules (e.g., weather, news, etc.).

---

## License

This project is licensed under the MIT License. See [LICENSE](https://github.com/WieWaldi/motd.sh/blob/master/LICENSE) for details.

Some parts of the code are published under the BSD-2-Clause License. Refer to the respective files for details.

---

## Credits

`motd.sh` is inspired by the following projects:

- [MOTD](https://github.com/HermannBjorgvin/MOTD) by Hermann Björgvin
- [Fancy MOTD](https://github.com/bcyran/fancy-motd) by Bazyli Cyran
- [dynamic_motd](https://github.com/sstallion/dynamic_motd) by Steve Stallion

---

## Links

- [BSD Magazine](https://bsdmag.org/) - BSD-related news, articles, and tutorials.
- [freebsd-dynamic-motd](https://github.com/rooty0/freebsd-dynamic-motd/blob/master/motd.sh) - Another dynamic MOTD script for FreeBSD.

---

Enjoy using `motd.sh`! 🎉
