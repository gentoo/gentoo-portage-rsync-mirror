# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htun/htun-0.9.5.ebuild,v 1.8 2009/01/14 03:47:53 vapier Exp $

inherit eutils

DESCRIPTION="Project to tunnel IP traffic over HTTP"
HOMEPAGE="http://htun.runslinux.net/"
SRC_URI="http://htun.runslinux.net/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-util/yacc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc.patch #248100
	sed -i \
		-e '/^CFLAGS/s:=\(.*\)-O :+=\1 $(CPPFLAGS) :' \
		-e '/LDFLAGS/s:=:+=:' \
		src/Makefile || die
}

src_compile() {
	cd src
	emake all || die
}

src_install() {
	dosbin src/htund || die
	insinto /etc
	doins doc/htund.conf
	dodoc doc/* README
}

pkg_postinst() {
	einfo "NOTE: HTun requires the Universal TUN/TAP module"
	einfo "available in the Linux kernel.  Make sure you have"
	einfo "compiled the tun.o driver as a module!"
	einfo
	einfo "It can be found in the kernel configuration under"
	einfo "Network Device Support --> Universal TUN/TAP"
	einfo
	einfo "To configure HTun, run the following commands as root:"
	einfo "  # mknod /dev/net/tun c 10 200"
	einfo "  # echo \"alias char-major-10-200 tun\" >> /etc/modules.conf"
	einfo "  # depmod -e"
}
