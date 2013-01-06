# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/timer_entropyd/timer_entropyd-0.1-r3.ebuild,v 1.3 2012/03/08 11:34:06 phajdan.jr Exp $

EAPI=2

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A timer-based entropy generator"
HOMEPAGE="http://www.vanheusden.com/te/"
SRC_URI="http://www.vanheusden.com/te/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

src_prepare() {
	sed -i -e 's:-O2::' Makefile || die
	epatch "${FILESDIR}"/${P}-syslog.patch
}

src_compile() {
	use debug && append-flags -D_DEBUG

	tc-export CC
	emake DEBUG= || die
}

src_install() {
	exeinto /usr/libexec
	doexe ${PN} || die "doexe failed"
	dodoc Changes readme.txt || die
	newinitd "${FILESDIR}/timer_entropyd.initd.1" ${PN} || die
}

pkg_postinst() {
	elog "To start ${PN} at boot do rc-update add ${PN} default"
	elog "To start ${PN} now do /etc/init.d/${PN} start"
	elog "To check the amount of entropy, cat /proc/sys/kernel/random/entropy_avail"
}
