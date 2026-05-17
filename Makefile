# +----------------------------------------------------------------------------+
# | ./motd.sh/Makefile                                                         |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Colorful motd written in bash. Server status at a glance.     |
# |    Requires: ---                                                           |
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

include config.mk
NO_OBJ=
CONFDIR=			${PREFIX}/etc
BASEDIR=			${PREFIX}/share/motd.sh
MODULESDIR=			${BASEDIR}/modules
SHAREDIR=			${PREFIX}/share

SCRIPTS=			bin/motd.sh
SCRIPTSDIR=			${PREFIX}/bin

LIBEXEC=			libexec/motd.sh libexec/motd.sh.framework
LIBEXECDIR=			${PREFIX}/libexec

DOCS=				CONTRIBUTING.md README.md LICENSE LICENSE_BSD LICENSE_MIT
DOCSDIR=			${SHAREDIR}/doc/motd.sh

CONFETC=			etc/motd.sh.conf

CONFRCD=			etc/rc.d/motd.sh
CONFRCDDIR=			${CONFDIR}/rc.d

CLEANFILES=			etc/rc.d/motd.sh libexec/motd.sh libexec/motd.sh.framework
PREFIX_SUB=			-e 's|@@PREFIX@@|${DESTDIR}${PREFIX}|g'

INSTALL_DATA=		install -m 0644
INSTALL_SCRIPT=		install -m 0555
UNINSTALL=			rm -rf
MKDIR=				mkdir -p

.PHONY: all options install uninstall

all: options

options:
	@echo "This build options:"
	@echo "PREFIX           = ${DESTDIR}${PREFIX}"
	@echo "BASEDIR          = ${DESTDIR}${BASEDIR}"
	@echo "SHAREDIR         = ${DESTDIR}${SHAREDIR}"
	@echo "MODULESDIR       = ${DESTDIR}${MODULESDIR}"
	@echo "CONFETC          = ${CONFETC}"
	@echo "CONFDIR          = ${DESTDIR}${CONFDIR}"
	@echo "LIBEXEC          = ${LIBEXEC}"
	@echo "LIBEXECDIR       = ${DESTDIR}${LIBEXECDIR}"
	@echo "SCRIPTS          = ${SCRIPTS}"
	@echo "SCRIPTSDIR       = ${DESTDIR}${SCRIPTSDIR}"
	@echo "DOCS             = ${DOCS}"
	@echo "DOCSDIR          = ${DESTDIR}${DOCSDIR}"
	@echo "CONFRCD          = ${CONFRCD}"
	@echo "CONFRCDIR        = ${DESTDIR}${CONFRCDDIR}"
	@echo "CLEANFILES       = ${CLEANFILES}"
	@echo "PREFIX_SUB       = ${PREFIX_SUB}"
	@echo "INSTALL_DATA     = ${INSTALL_DATA}"
	@echo "INSTALL_SCRIPT   = ${INSTALL_SCRIPT}"
	@echo "UNINSTALL        = ${UNINSTALL}"
	@echo "MKDIR            = ${MKDIR}"

installdirs:
	for dir in ${CONFRCDDIR} ${CONFDIR} ${SCRIPTSDIR} ${MODULESDIR} ${LIBEXECDIR} ${DOCSDIR}; do \
		echo "Make Directory: ${DESTDIR}$${dir}"; \
		${MKDIR} ${DESTDIR}$${dir}; \
	done

install: options installdirs
	@echo "Installing rc.d config file to ${DESTDIR}${CONFRCDDIR}"
	sed ${PREFIX_SUB} etc/rc.d/motd.sh > "${DESTDIR}${CONFRCDDIR}/motd.sh"
	@echo "Installing executable file to ${DESTDIR}${SCRIPTSDIR}"
	${INSTALL_SCRIPT}		${SCRIPTS}		${DESTDIR}${SCRIPTSDIR}
	@echo "Installing library files to ${DESTDIR}${LIBEXECDIR}"
	sed ${PREFIX_SUB} libexec/motd.sh > "${DESTDIR}${LIBEXECDIR}/motd.sh"
	sed ${PREFIX_SUB} libexec/motd.sh.framework > "${DESTDIR}${LIBEXECDIR}/motd.sh.framework"
	@echo "Installing configuration file to ${DESTDIR}${CONFDIR}"
	${INSTALL_SCRIPT}		${CONFETC}		${DESTDIR}${CONFDIR}
	@echo "Installing documentation files to ${DESTDIR}${DOCSDIR}"
	${INSTALL_DATA}		${DOCS}				${DESTDIR}${DOCSDIR}
	@echo "Installing modules to ${DESTDIR}${MODULESDIR}"
	cp -f modules/* ${DESTDIR}${MODULESDIR}
	@echo "Setting permissions for executable files in ${MODULESDIR}"
	chmod 755 ${DESTDIR}${MODULESDIR}/*

uninstall: clean
	@echo "Removing rc.d config file from ${DESTDIR}${CONFRCDDIR}"
	${UNINSTALL}			${DESTDIR}${CONFRCDDIR}/motd.sh
	@echo "Removing executable file from ${DESTDIR}${SCRIPTSDIR}"
	${UNINSTALL}			${DESTDIR}${SCRIPTSDIR}/motd.sh
	@echo "Removing library files from ${DESTDIR}${LIBEXECDIR}"
	${UNINSTALL}			${DESTDIR}${LIBEXECDIR}/motd.sh.framework
	${UNINSTALL}			${DESTDIR}${LIBEXECDIR}/motd.sh
	@echo "Removing configuration file from ${DESTDIR}${CONFDIR}"
	${UNINSTALL}			${DESTDIR}${CONFDIR}/motd.sh.conf
	@echo "Removing documentation files from ${DESTDIR}${DOCSDIR}"
	${UNINSTALL}			${DESTDIR}${DOCSDIR}
	@echo "Removing modules from ${DESTDIR}${MODULESDIR}"
	${UNINSTALL}			${DESTDIR}${MODULESDIR}
	@echo "Removing ${DESTDIR}${BASEDIR}"
	${UNINSTALL}			${DESTDIR}${BASEDIR}

clean:
	@echo "Nothing to do."
