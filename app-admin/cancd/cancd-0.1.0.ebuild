# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cancd/cancd-0.1.0.ebuild,v 1.4 2014/08/10 01:37:44 patrick Exp $

DESCRIPTION="This is the CA NetConsole Daemon, a daemon to receive output from
the Linux netconsole driver"
HOMEPAGE="http://oss.oracle.com/projects/cancd/"
SRC_URI="http://oss.oracle.com/projects/cancd/dist/files/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	# slight makefile cleanup
	sed -i.orig \
		-e '/^CFLAGS/s,-g,,' \
		-e '/^CFLAGS/s,-O2,,' \
		-e '/rm cancd cancd.o/s,rm,rm -f,' \
		"${S}"/Makefile
}

src_compile() {
	emake cancd
}

src_install() {
	into /usr
	dosbin cancd
	newinitd "${FILESDIR}"/cancd-init.d cancd
	newconfd "${FILESDIR}"/cancd-conf.d cancd
	keepdir /var/crash
	fowners adm:nobody /var/crash
	fperms 700 /var/crash
}
