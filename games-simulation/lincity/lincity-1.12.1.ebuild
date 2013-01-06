# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity/lincity-1.12.1.ebuild,v 1.9 2010/01/12 23:40:13 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="city/country simulation game for X and Linux SVGALib"
HOMEPAGE="http://lincity.sourceforge.net/"
SRC_URI="mirror://sourceforge/lincity/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="nls svga X"

# dep fix (bug #82318)
RDEPEND="nls? ( virtual/libintl )
	svga? ( media-libs/svgalib )
	X? (
		x11-libs/libXext
		x11-libs/libSM )
	!svga? (
		x11-libs/libXext
		x11-libs/libSM )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e '/^localedir/s:$(datadir):/usr/share:' \
		po/Makefile.in.in \
		intl/Makefile.in \
		|| die 'sed failed'
}

src_configure() {
	local myconf

	if ! use X && ! use svga ; then
		myconf="--with-x"
	fi
	egamesconf \
		--disable-dependency-tracking \
		--with-gzip \
		$(use_enable nls) \
		$(use_with svga) \
		$(use_with X x) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Acknowledgements CHANGES README* TODO
	if use X || ! use svga ; then
		make_desktop_entry xlincity Lincity
	fi
	prepgamesdirs
}
