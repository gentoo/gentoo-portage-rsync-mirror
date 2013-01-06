# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powernowd/powernowd-1.00.ebuild,v 1.3 2011/08/13 08:19:27 xarthisius Exp $

EAPI="2"

inherit linux-info

DESCRIPTION="Daemon to control the speed and voltage of CPUs"
HOMEPAGE="http://www.deater.net/john/powernowd.html"
SRC_URI="http://www.deater.net/john/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

pkg_setup() {
	CONFIG_CHECK="~CPU_FREQ"
	WARNING_CPU_FREQ="Powernowd needs CPU_FREQ turned on!"
	linux-info_pkg_setup
}

src_prepare() {
	rm -f "${S}"/Makefile
}

src_compile() {
	emake powernowd || die "emake failed"
}

src_install() {
	dosbin powernowd || die
	dodoc README

	newconfd "${FILESDIR}"/powernowd.confd powernowd
	newinitd "${FILESDIR}"/powernowd.initd powernowd
}
