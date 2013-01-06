# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dropwatch/dropwatch-1.4.ebuild,v 1.1 2012/10/24 09:46:02 pinkbyte Exp $

EAPI=4

inherit base linux-info toolchain-funcs

DESCRIPTION="An utility to interface to the kernel to monitor for dropped network packets"
HOMEPAGE="https://fedorahosted.org/dropwatch/"
SRC_URI="https://fedorahosted.org/releases/d/r/dropwatch/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libnl:3
	sys-libs/readline"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~NET_DROP_MONITOR"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	emake CC="$(tc-getCC)" -C src
}

src_install() {
	dobin "src/${PN}"
	doman "doc/${PN}.1"
	dodoc README
}

pkg_postinst() {
	einfo "Ensure that 'drop_monitor' kernel module is loaded before running ${PN}"
}
