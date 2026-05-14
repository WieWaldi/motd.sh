# motd.sh
include config.mk

.PHONY: all options install uninstall

all: options

options:
	@echo "This build options:"
	@echo "PREFIX     = ${PREFIX}"
	@echo "CONFDIR    = ${CONFDIR}"
	@echo "BASEDIR    = ${BASEDIR}"
	@echo "MODULES    = ${MODULES}"

install:
	@echo "Make Diretory: ${PREFIX}/bin"
	@mkdir -p ${PREFIX}/bin
	@echo "Make Diretory: ${CONFDIR}"
	@mkdir -p ${CONFDIR}
	@echo "Make Directory: ${BASEDIR}"
	@mkdir -p ${BASEDIR}
	@echo "Make Diretory: ${MODULES}"
	@mkdir -p ${MODULES}
	@echo "Installing executable file to ${PREFIX}/bin"
	@cp -f motd.sh ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/motd.sh
	@echo "Installing configuration file to ${CONFDIR}"
	@cp -f motd.sh.conf ${CONFDIR}
	@echo "Installing base files to ${BASEDIR}"
	@cp -f motd.sh.framework ${BASEDIR}
	@cp -f LICENSE ${BASEDIR}
	@cp -f README.md ${BASEDIR}
	@echo "Installing modules to ${MODULES}"
	@cp -f modules/* ${MODULES}

uninstall:
	@echo "Removing executable file from ${PREFIX}/bin"
	@rm -f ${PREFIX}/bin/motd.sh
	@echo "Removing configuration file from ${CONFDIR}"
	@rm -f ${CONFDIR}/motd.sh.conf
	@echo "Removing modules from ${MODULES}"
	@rm -f ${MODULES}/*

clean:
	@echo "Nothing to do."
