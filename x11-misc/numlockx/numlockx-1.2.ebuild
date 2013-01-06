# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.2.ebuild,v 1.8 2012/05/16 00:17:42 ssuominen Exp $

EAPI=4
inherit autotools

DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://home.kde.org/~seli/numlockx/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_prepare() {
	sed -i -e '/^K_.*$/d' configure.in || die
	sed -i -e 's,@X_[_A-Z]\+@,,g' Makefile.am || die
	eautoreconf
}

src_install() {
	dobin ${PN}
	dodoc AUTHORS README
}

pkg_postinst() {
	elog
	elog "add 'numlockx' to your X startup programs to have numlock turn on when X starts"
	elog
}
