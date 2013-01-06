# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.7.2-r1.ebuild,v 1.10 2012/05/21 18:38:03 xarthisius Exp $
EAPI=2
inherit autotools eutils
MY_P=${P/tex/TeX}-src

DESCRIPTION="Wysiwyg text processor with high-quality maths"
HOMEPAGE="http://www.texmacs.org/"
SRC_URI="
	ftp://ftp.texmacs.org/pub/TeXmacs/targz/${MY_P}.tar.gz
	ftp://ftp.texmacs.org/pub/TeXmacs/targz/TeXmacs-600dpi-fonts.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="imlib jpeg netpbm svg spell"
KEYWORDS="alpha amd64 ppc sparc x86"

RDEPEND="
	dev-scheme/guile[deprecated]
	virtual/latex-base
	app-text/ghostscript-gpl
	media-libs/freetype
	x11-libs/libXext
	x11-apps/xmodmap
	imlib? ( media-libs/imlib2 )
	jpeg? ( || ( media-gfx/imagemagick media-gfx/jpeg2ps ) )
	svg? ( || ( media-gfx/inkscape gnome-base/librsvg:2 ) )
	netpbm? ( media-libs/netpbm )
	spell? ( app-text/aspell )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# don't strip
	epatch "${FILESDIR}"/${PN}-strip.patch

	# fix LD_LIBRARY_PATH in tm_mupad_help, bug #337532
	epatch "${FILESDIR}"/${PN}-mupad.patch

	eautoreconf
}

src_configure() {
	econf $(use_with imlib imlib2) \
		--enable-optimize="${CXXFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO || die "dodoc failed"
	domenu "${FILESDIR}"/TeXmacs.desktop || die "domenu failed"

	# now install the fonts
	insinto /usr/share/texmf
	doins -r "${WORKDIR}/fonts" || die "installing fonts failed"
}
