# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/euler/euler-1.61.0.ebuild,v 1.10 2012/05/04 07:46:51 jdhore Exp $

EAPI="1"

inherit autotools eutils

DESCRIPTION="Mathematical programming environment"
HOMEPAGE="http://euler.sourceforge.net/"
SRC_URI="mirror://sourceforge/euler/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc -sparc x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	virtual/pkgconfig"

RDEPEND="x11-libs/gtk+:2
	x11-misc/xdg-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/configure-gentoo.patch
	epatch "${FILESDIR}"/command-gcc4-gentoo.patch
	epatch "${FILESDIR}"/${PN}-glibc-2.4-gentoo.patch
	epatch "${FILESDIR}"/${PN}-xdg.patch
	epatch "${FILESDIR}"/${PN}-fortify.patch
	# gentoo specific stuff
	sed -i -e '/COPYING/d' -e '/INSTALL/d' Makefile.am
	sed -i \
		-e "s:doc/euler:doc/${PF}:g" \
		Makefile.am docs/Makefile.am \
		docs/*/Makefile.am docs/*/images/Makefile.am \
		src/main.c \
		|| die "sed for docs failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
