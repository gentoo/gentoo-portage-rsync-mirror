# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kanatest/kanatest-0.4.8.ebuild,v 1.10 2012/08/07 16:31:47 naota Exp $

EAPI="1"

inherit eutils autotools

DESCRIPTION="Visual flashcard tool for memorizing the Japanese Hiragana and Katakana alphabet"
HOMEPAGE="http://www.clayo.org/kanatest"
SRC_URI="http://www.clayo.org/kanatest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12:2
	dev-libs/libxml2:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}+gtk-2.22.patch \
		"${FILESDIR}"/${P}-autoconf.patch \
		"${FILESDIR}"/${P}-cflags.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS TRANSLATORS ChangeLog README || die
}
