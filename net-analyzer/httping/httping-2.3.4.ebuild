# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-2.3.4.ebuild,v 1.6 2014/04/20 11:22:05 ago Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE="debug fftw ncurses ssl tfo"

RDEPEND="
	fftw? ( sci-libs/fftw:3.0 )
	ncurses? ( >=sys-libs/ncurses-5 )
	ssl? ( dev-libs/openssl )
"
DEPEND="
	${RDEPEND}
	ncurses? ( virtual/pkgconfig )
"

# This would bring in test? ( dev-util/cppcheck ) but unlike
# upstream we should only care about compile/run time testing
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.1-flags.patch
}

src_configure() {
	# not an autotools script
	echo > makefile.inc || die

	use ncurses && LDFLAGS+=" $( $( tc-getPKG_CONFIG ) --libs ncurses )"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		FW=$(usex fftw) \
		DEBUG=$(usex debug) \
		NC=$(usex ncurses) \
		SSL=$(usex ssl) \
		TFO=$(usex tfo)
}

src_install() {
	dobin httping
	doman httping.1
}
