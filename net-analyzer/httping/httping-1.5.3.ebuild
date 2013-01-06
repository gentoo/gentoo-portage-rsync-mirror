# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.5.3.ebuild,v 1.5 2012/06/14 02:42:25 jdhore Exp $

EAPI=4
inherit flag-o-matic toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE="debug ssl"

RDEPEND=">=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		$(use ssl && echo SSL=yes || echo SSL=no) \
		$(use debug && echo DEBUG=yes || echo DEBUG=no)
}

src_install() {
	dobin httping
	doman httping.1
	dodoc readme.txt
}
