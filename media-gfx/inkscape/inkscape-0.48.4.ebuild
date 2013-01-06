# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.48.4.ebuild,v 1.7 2012/12/27 17:24:48 ago Exp $

EAPI=5

PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"

GCONF_DEBUG=no

inherit autotools eutils flag-o-matic gnome2 python toolchain-funcs

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="dia gnome postscript inkjar lcms nls spell wmf"

RESTRICT="test"

COMMON_DEPEND="
	>=app-text/poppler-0.12.3-r3[cairo,xpdf-headers(+)]
	dev-cpp/glibmm
	>=dev-cpp/gtkmm-2.18.0:2.4
	>=dev-libs/boehm-gc-6.4
	>=dev-libs/glib-2.6.5
	>=dev-libs/libsigc++-2.0.12
	>=dev-libs/libxml2-2.6.20
	>=dev-libs/libxslt-1.0.15
	dev-libs/popt
	dev-python/lxml
	media-gfx/imagemagick[cxx]
	media-libs/fontconfig
	media-libs/freetype:2
	>=media-libs/libpng-1.2
	app-text/libwpd:0.9
	app-text/libwpg:0.2
	sci-libs/gsl
	x11-libs/libX11
	>=x11-libs/gtk+-2.10.7:2
	>=x11-libs/pango-1.4.0
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	lcms? ( media-libs/lcms:2 )
	spell? (
		app-text/aspell
		app-text/gtkspell:2
	)"

# These only use executables provided by these packages
# See share/extensions for more details. inkscape can tell you to
# install these so we could of course just not depend on those and rely
# on that.
RDEPEND="
	${COMMON_DEPEND}
	dev-python/numpy
	media-gfx/uniconvertor
	dia? ( app-office/dia )
	postscript? ( app-text/ghostscript-gpl )
	wmf? ( media-libs/libwmf )"

DEPEND="${COMMON_DEPEND}
	dev-libs/boost
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog NEWS README*"

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${PN}-0.48.0-spell.patch \
		"${FILESDIR}"/${PN}-0.48.2-libwpg.patch \
		"${FILESDIR}"/${PN}-0.48.3.1-desktop.patch \
		"${FILESDIR}"/${P}-python2.patch \
		"${FILESDIR}"/${PN}-0.48.4-fix-member-decl.patch

	eautoreconf

	# bug 421111
	python_convert_shebangs -r 2 share/extensions
}

src_configure() {
	G2CONF="${G2CONF}
		--without-perl
		--enable-poppler-cairo
		$(use_with gnome gnome-vfs)
		$(use_with inkjar)
		$(use_enable lcms)
		$(use_enable nls)
		$(use_with spell aspell)
		$(use_with spell gtkspell)"

	# aliasing unsafe wrt #310393
	append-flags -fno-strict-aliasing
	gnome2_src_configure
}

src_compile() {
	emake AR="$(tc-getAR)"
}
