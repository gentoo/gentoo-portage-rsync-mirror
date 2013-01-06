# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.50-r1.ebuild,v 1.3 2012/05/05 07:00:18 jdhore Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Translate PostScript and PDF graphics into other vector formats"
HOMEPAGE="http://sourceforge.net/projects/pstoedit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emf flash imagemagick plotutils"

RDEPEND=">=media-libs/libpng-1.4.3
	>=media-libs/gd-2.0.35-r1
	>=app-text/ghostscript-gpl-8.71-r1
	emf? ( >=media-libs/libemf-1.0.3 )
	flash? ( >=media-libs/ming-0.4.3 )
	imagemagick? ( >=media-gfx/imagemagick-6.6.1.2[cxx] )
	plotutils? ( media-libs/plotutils )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e '/CXXFLAGS="-g"/d' \
		-e 's:-pedantic::' \
		configure.ac || die

	epatch "${FILESDIR}"/${P}-parallel.patch \
		"${FILESDIR}"/${P}-plugin-close.patch \
		"${FILESDIR}"/${P}-swf.patch

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with emf) \
		$(use_with imagemagick magick) \
		$(use_with plotutils libplot) \
		$(use_with flash swf)
}

src_install() {
	emake DESTDIR="${D}" install || die
	doman doc/pstoedit.1 || die
	dodoc doc/*.txt
	dohtml doc/*.htm
}
