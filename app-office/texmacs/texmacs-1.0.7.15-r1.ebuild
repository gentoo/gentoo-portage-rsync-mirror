# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.7.15-r1.ebuild,v 1.2 2012/05/21 18:38:03 xarthisius Exp $

EAPI=4

inherit autotools eutils

MY_P=${P/tex/TeX}-src

DESCRIPTION="Wysiwyg text processor with high-quality maths"
HOMEPAGE="http://www.texmacs.org/"
SRC_URI="ftp://ftp.texmacs.org/pub/TeXmacs/tmftp/source/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="imlib jpeg netpbm qt4 svg spell"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux"

RDEPEND="dev-scheme/guile[deprecated]
	virtual/latex-base
	app-text/ghostscript-gpl
	media-libs/freetype
	x11-libs/libXext
	x11-apps/xmodmap
	qt4? ( x11-libs/qt-gui:4 )
	imlib? ( media-libs/imlib2 )
	jpeg? ( || ( media-gfx/imagemagick media-gfx/jpeg2ps ) )
	svg? ( || ( media-gfx/inkscape gnome-base/librsvg:2 ) )
	netpbm? ( media-libs/netpbm )
	spell? ( app-text/aspell )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# respect LDFLAGS, bug #338459
	epatch "${FILESDIR}"/${PN}-ldflags.patch
	# fix a typo in tm-files.scm
	epatch "${FILESDIR}"/${P}-tm-files.patch

	eautoreconf
}

src_configure() {
	econf \
		$(use_with imlib imlib2) \
		--enable-optimize="${CXXFLAGS}" \
		$(use_enable qt4 qt)
}

src_install() {
	default
	domenu "${FILESDIR}"/TeXmacs.desktop
}
