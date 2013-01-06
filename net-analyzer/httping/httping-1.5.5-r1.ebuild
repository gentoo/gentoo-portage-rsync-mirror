# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.5.5-r1.ebuild,v 1.1 2012/11/19 11:12:38 jer Exp $

EAPI=4
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
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
	epatch "${FILESDIR}"/${PN}-1.5.5-help.patch
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
