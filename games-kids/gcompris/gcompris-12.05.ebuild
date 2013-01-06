# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-12.05.ebuild,v 1.7 2012/11/07 20:14:51 tetromino Exp $

EAPI=2
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite threads"

inherit autotools eutils python games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net/"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnet"

RDEPEND="x11-libs/gtk+:2
	gnome-base/librsvg[gtk]
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-good:0.10
	media-plugins/gst-plugins-ogg:0.10
	media-plugins/gst-plugins-alsa:0.10
	media-plugins/gst-plugins-vorbis:0.10
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	dev-libs/popt
	virtual/libintl
	games-board/gnuchess
	dev-db/sqlite:3
	gnet? ( net-libs/gnet:2 )
	dev-python/pygtk"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	dev-perl/XML-Parser
	sys-devel/gettext
	sys-apps/texinfo
	app-text/texi2html
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	media-gfx/tuxpaint
	sci-electronics/gnucap"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_prepare() {
	# Drop DEPRECATED flags, bug #387817
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		src/gcompris/Makefile.am src/gcompris/Makefile.in \
		src/goocanvas/src/Makefile.am src/goocanvas/src/Makefile.in \
		|| die

	epatch "${FILESDIR}"/${P}-build.patch
	cp /usr/share/gettext/config.rpath .
	eautoreconf
	sed -i \
		-e 's#^itlocaledir =.*$#itlocaledir = @localedir@#' \
		po/Makefile.in.in || die

	# Fix desktop files
	sed -i '/Encoding/d' gcompris.desktop.in || die
	sed -i '/Encoding/d' gcompris-edit.desktop.in || die
}

src_configure() {
	GNUCHESS="${GAMES_BINDIR}"/gnuchess \
	egamesconf \
		--disable-dependency-tracking \
		--datarootdir="${GAMES_DATADIR}" \
		--datadir="${GAMES_DATADIR}" \
		--localedir=/usr/share/locale \
		--infodir=/usr/share/info \
		--with-python="$(PYTHON -a)" \
		$(use_enable gnet) \
		--enable-sqlite \
		--enable-py-build-only
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -exec rm -f '{}' +
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
