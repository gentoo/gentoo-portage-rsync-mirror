# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.9.4-r4.ebuild,v 1.11 2012/05/03 07:11:34 jdhore Exp $

EAPI="1"

inherit eutils toolchain-funcs

IUSE="truetype gtk imlib bidi nls uim scim m17n-lib"
#IUSE="${IUSE} iiimf"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz
	http://shinh.skr.jp/dat_dir/${P}_256.patch"

SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
LICENSE="BSD"

RDEPEND="|| ( sys-libs/libutempter sys-apps/utempter )
	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	gtk? ( x11-libs/gtk+:2 )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	truetype? ( x11-libs/libXft )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( virtual/libintl )
	uim? ( >=app-i18n/uim-1.0 )
	scim? ( >=app-i18n/scim-1.4 )
	m17n-lib? ( >=dev-libs/m17n-lib-1.2.0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-uim15-fix.patch
	epatch "${DISTDIR}"/${P}_256.patch
	cd "${S}"/xwindow
	epatch "${FILESDIR}"/${PN}-2.9.1-gentoo.diff
	epatch "${FILESDIR}"/${PN}-2.9.3-asneeded.diff
}

src_compile() {
	local myconf

	if use gtk ; then
		myconf="${myconf} --with-imagelib=gdk-pixbuf"
	else
		if use imlib ; then
			myconf="${myconf} --with-imagelib=imlib"
		else
			myconf="${myconf} --with-imagelib=''"
		fi
		myconf="${myconf} --with-tools=mlclient,mlcc"
	fi

	# iiimf isn't stable enough
	#myconf="${myconf} $(use_enable iiimf)"

	econf --enable-utmp \
		$(use_enable truetype anti-alias) \
		$(use_enable bidi fribidi) \
		$(use_enable nls) \
		$(use_enable uim) \
		$(use_enable scim) \
		$(use_enable m17n-lib m17nlib) \
		${myconf} || die "econf failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die

	dodoc ChangeLog README

	docinto ja
	dodoc doc/ja/*
	docinto en
	dodoc doc/en/*
}
