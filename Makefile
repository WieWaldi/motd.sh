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
SCRIPTSDIR=			${LIBEXECDIR}

LIBEXEC=			libexec/motd.sh libexec/motd.sh.framework
LIBEXECDIR=			${PREFIX}/libexec

DOCS=				CONTRIBUTING.md README.md LICENSE LICENSE_BSD LICENSE_MIT
DOCSDIR=			${SHAREDIR}/doc/motd.sh

CONFETC=			etc/motd.sh.conf

CONFRCD=			etc/rc.d/motd.sh
CONFRCDDIR=			${CONFDIR}/rc.d

CLEANFILES=			etc/rc.d/motd.sh libexec/motd.sh libexec/motd.sh.framework
PREFIX_SUB=			-e 's,@@PREFIX@@,${PREFIX},g'

INSTALL_DATA=		install -m 0644
INSTALL_SCRIPT=		install -m 0555
MKDIR=				mkdir -p

.PHONY: all options install uninstall

all: options

options:
	@echo "This build options:"
	@echo "PREFIX                                       = ${DESTDIR}${PREFIX}"
	@echo "BASEDIR                                      = ${DESTDIR}${BASEDIR}"
	@echo "SHAREDIR                                     = ${DESTDIR}${SHAREDIR}"
	@echo "MODULESDIR                                   = ${DESTDIR}${MODULESDIR}"
	@echo "CONFETC                                      = ${CONFETC}"
	@echo "CONFDIR                                      = ${DESTDIR}${CONFDIR}"
	@echo "LIBEXEC                                      = ${LIBEXEC}"
	@echo "LIBEXECDIR                                   = ${DESTDIR}${LIBEXECDIR}"
	@echo "SCRIPTS                                      = ${SCRIPTS}"
	@echo "SCRIPTSDIR                                   = ${DESTDIR}${SCRIPTSDIR}"
	@echo "DOCS                                         = ${DOCS}"
	@echo "DOCSDIR                                      = ${DESTDIR}${DOCSDIR}"
	@echo "CONFRCD                                      = ${CONFRCD}"
	@echo "CONFRCDIR                                    = ${DESTDIR}${CONFRCDDIR}"
	@echo "CLEANFILES                                   = ${CLEANFILES}"
	@echo "PREFIX_SUB                                   = ${PREFIX_SUB}"
	@echo "INSTALL_DATA                                 = ${INSTALL_DATA}"
	@echo "INSTALL_SCRIPT                               = ${INSTALL_SCRIPT}"
	@echo "MKDIR                                        = ${MKDIR}"

rc.d/motd.sh: rc.d/motd.sh.in
	sed ${PREFIX_SUB} ${.ALLSRC} >${.TARGET}

libexec/motd.sh: libexec/motd.sh.in
	sed ${PREFIX_SUB} ${.ALLSRC} >${.TARGET}

installdirs:
	.for dir in ${CONFRCDIR} ${CONFDIR} ${SCRIPTSDIR} ${MODULESDIR} ${LIBEXECDIR} ${DOCSDIR}
		@echo "Make Directory: ${DESTDIR}${dir}"
		${MKDIR} ${DESTDIR}${dir}
	.endfor

install: options installdirs rc.d/motd.sh libexec/motd.sh
	${INSTALL_SCRIPT}       ${CONFRCD}  ${DESTDIR}${CONFRCDDIR}
	${INSTALL_SCRIPT}       ${SCRIPTS}  ${DESTDIR}${SCRIPTSDIR}
	${INSTALL_SCRIPT}       ${LIBEXEC}  ${DESTDIR}${LIBEXECDIR}
	${INSTALL_SCRIPT}       ${CONFETC}  ${DESTDIR}${CONFDIR}
	${INSTALL_DATA}         ${DOCS}     ${DESTDIR}${DOCSDIR}
	@cp -f modules/* ${MODULESDIR}
	@chmod 755 ${MODULESDIR}/*

uninstall:
	@echo "Removing executable file from ${PREFIX}/bin"
	@rm -f {CONFRCD}
	@rm -f {SCRIPTS}
	@rm -f {LIBEXEC}
	@echo "Removing configuration file from ${CONFDIR}"
	@rm -f ${CONFDIR}/motd.sh.conf
	@echo "Removing modules from ${MODULESDIR}"
	@rm -f ${MODULES}/*

clean:
	@echo "Nothing to do."
