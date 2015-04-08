# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sam2p/sam2p-0.47.ebuild,v 1.7 2010/10/05 20:43:00 maekke Exp $

EAPI=2
inherit autotools eutils toolchain-funcs

DESCRIPTION="Utility to convert raster images to EPS, PDF and many others"
HOMEPAGE="http://code.google.com/p/sam2p/"
SRC_URI="http://sam2p.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="examples gif"

RDEPEND=""
DEPEND="dev-lang/perl"

RESTRICT="test"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.45-fbsd.patch \
		"${FILESDIR}"/${PN}-0.45-nostrip.patch \
		"${FILESDIR}"/${PN}-0.45-cflags.patch

	touch stdafx.h bts2.tth #315619

	eautoreconf
}

src_configure() {
	tc-export CXX
	econf \
		--enable-lzw \
		$(use_enable gif)

	rm -f stdafx.h bts2.tth
}

src_install() {
	dobin sam2p || die
	dodoc README

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
