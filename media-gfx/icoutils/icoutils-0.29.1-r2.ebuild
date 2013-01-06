# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icoutils/icoutils-0.29.1-r2.ebuild,v 1.5 2012/09/13 12:52:45 ssuominen Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="A set of programs for extracting and converting images in icon and cursor files (.ico, .cur)"
HOMEPAGE="http://www.nongnu.org/icoutils/"
SRC_URI="http://savannah.nongnu.org/download/icoutils/${P}.tar.bz2"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

RDEPEND="media-libs/libpng
		nls? ( virtual/libintl )
		>=dev-lang/perl-5.6
		>=dev-perl/libwww-perl-5.64"

DEPEND="${RDEPEND}
		nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-locale.patch
	epatch "${FILESDIR}"/${P}-gettext.patch
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	econf \
		`use_enable nls` \
		--disable-dependency-tracking || die
}

src_install() {
	emake DESTDIR="${D}" mkinstalldirs="mkdir -p" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
