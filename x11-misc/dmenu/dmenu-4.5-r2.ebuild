# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-4.5-r2.ebuild,v 1.7 2013/01/28 02:54:01 jer Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/dmenu/"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE="xft xinerama"

DEPEND="
	x11-libs/libX11
	xft? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )
"
RDEPEND="${DEPEND}"

src_prepare() {
	# Respect our flags
	sed -i \
		-e '/^CFLAGS/{s|=.*|+= -ansi -pedantic -Wall ${INCS} ${CPPFLAGS}|}' \
		-e 's|LDFLAGS  = -s|LDFLAGS  +=|' \
		-e 's|XINERAMALIBS  =|XINERAMALIBS  ?=|' \
		-e 's|XINERAMAFLAGS =|XINERAMAFLAGS ?=|' \
		config.mk || die
	# Make make verbose
	sed -i \
		-e 's|^	@|	|g' \
		-e '/^	echo/d' \
		Makefile || die
	use xft && epatch "${FILESDIR}"/${PN}-4.5-xft.patch

	epatch_user
}

src_compile() {
	if use xinerama; then
		emake CC=$(tc-getCC)
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS=""
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
