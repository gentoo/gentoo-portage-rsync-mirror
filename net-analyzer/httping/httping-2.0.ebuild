# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-2.0.ebuild,v 1.2 2013/03/20 18:13:35 jer Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug ssl tfo"

RDEPEND="
	>=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )
"
DEPEND="${RDEPEND}"

# This would bring in test? ( dev-util/cppcheck ) but unlike
# upstream we should only care about compile/run time testing
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0-flags.patch
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		SSL=$(usex ssl) \
		TFO=$(usex tfo) \
		DEBUG=$(usex debug)
}

src_install() {
	dobin httping
	doman httping.1
	dodoc readme.txt
}
