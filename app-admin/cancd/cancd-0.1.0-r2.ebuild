# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cancd/cancd-0.1.0-r2.ebuild,v 1.1 2011/12/31 15:42:32 idl0r Exp $

inherit eutils

DESCRIPTION="the CA NetConsole Daemon, a daemon to receive output from the Linux netconsole driver"
HOMEPAGE="http://oss.oracle.com/projects/cancd/"
SRC_URI="http://oss.oracle.com/projects/cancd/dist/files/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch #246734
	epatch "${FILESDIR}"/${P}-c-cleanup.patch
	# slight makefile cleanup
	sed -i \
		-e '/^CFLAGS/s,-g,,' \
		-e '/^CFLAGS/s,-O2,-Wall -W -Wextra -Wundef -Wendif-labels -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wcast-align -Wwrite-strings -Wconversion -Wsign-compare -Waggregate-return -Wstrict-prototypes -Wredundant-decls -Wunreachable-code -Wlong-long,' \
		-e '/rm cancd cancd.o/s,rm,rm -f,' \
		Makefile || die
}

src_compile() {
	emake cancd || die "emake failed"
}

src_install() {
	dosbin cancd || die "dosbin failed"
	newinitd "${FILESDIR}"/cancd-init.d cancd
	newconfd "${FILESDIR}"/cancd-conf.d cancd
	newinitd "${FILESDIR}"/netconsole-init.d netconsole
	newconfd "${FILESDIR}"/netconsole-conf.d netconsole
	keepdir /var/crash
	fowners adm:nobody /var/crash
	fperms 700 /var/crash
}
