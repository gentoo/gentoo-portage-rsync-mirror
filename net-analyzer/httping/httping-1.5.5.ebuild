# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.5.5.ebuild,v 1.5 2012/11/19 14:12:27 ago Exp $

EAPI=4
inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE="debug ssl"

RDEPEND="
	>=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )
"
DEPEND="${RDEPEND}"

# This would bring in test? ( dev-util/cppcheck ) but unlike
# upstream we should only care about compile/run time testing
RESTRICT="test"

src_prepare() {
	sed -i "/^OFLAGS/d" Makefile || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		SSL=$(usex ssl) \
		DEBUG=$(usex debug)
}

src_install() {
	dobin httping
	doman httping.1
	dodoc readme.txt
}
