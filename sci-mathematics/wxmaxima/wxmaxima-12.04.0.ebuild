# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/wxmaxima/wxmaxima-12.04.0.ebuild,v 1.1 2012/06/06 21:44:02 bicatali Exp $

EAPI=4
WX_GTK_VER="2.8"
inherit eutils wxwidgets fdo-mime

MYP=wxMaxima-${PV}

DESCRIPTION="Graphical frontend to Maxima, using the wxWidgets toolkit."
HOMEPAGE="http://wxmaxima.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="unicode"

DEPEND="dev-libs/libxml2:2
	x11-libs/wxGTK:2.8"
RDEPEND="${DEPEND}
	media-fonts/jsmath
	sci-visualization/gnuplot[wxwidgets]
	sci-mathematics/maxima"

S="${WORKDIR}/${MYP}"

src_prepare() {
	# consistent package names
	sed -e "s:\${datadir}/wxMaxima:\${datadir}/${PN}:g" \
		-i Makefile.in data/Makefile.in || die "sed failed"

	sed -e 's:share/wxMaxima:share/wxmaxima:g' \
		-i src/wxMaxima.cpp src/wxMaximaFrame.cpp src/Config.cpp \
		|| die "sed failed"
}

src_configure() {
	econf \
		--enable-dnd \
		--enable-printing \
		--with-wx-config=${WX_CONFIG} \
		$(use_enable unicode unicode-glyphs)
}

src_install () {
	default
	doicon data/wxmaxima.png
	make_desktop_entry wxmaxima wxMaxima wxmaxima
	dodir /usr/share/doc/${PF}
	dosym /usr/share/${PN}/README /usr/share/doc/${PF}/README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
