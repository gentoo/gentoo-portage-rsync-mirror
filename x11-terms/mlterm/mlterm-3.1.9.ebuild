# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-3.1.9.ebuild,v 1.1 2013/04/19 09:30:38 naota Exp $

EAPI="5"
inherit autotools-utils autotools eutils

IUSE="bidi debug gtk ibus libssh2 m17n-lib nls scim static-libs uim xft"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
LICENSE="BSD"

RDEPEND="|| ( sys-libs/libutempter sys-apps/utempter )
	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	gtk? ( x11-libs/gtk+:2 )
	xft? ( x11-libs/libXft )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	ibus? ( >=app-i18n/ibus-1.3 )
	libssh2? ( net-libs/libssh2 )
	nls? ( virtual/libintl )
	uim? ( >=app-i18n/uim-1.0 )
	scim? ( >=app-i18n/scim-1.4 )
	m17n-lib? ( >=dev-libs/m17n-lib-1.2.0 )"
#	vte? ( x11-libs/vte )
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=(
	"${FILESDIR}"/${PN}-3.0.5-ibus.patch
)
DOCS=( ChangeLog README doc/ja doc/en )

#AUTOTOOLS_AUTORECONF=1

src_prepare() {
	autotools-utils_src_prepare
	mv contrib/tool/mlcc/configure.in contrib/tool/mlcc/configure.ac || die
	cd "${S}"/contrib/tool/mlcc
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-utmp
		$(use_enable bidi fribidi)
		$(use_enable debug)
		$(use_enable ibus)
		$(use_enable libssh2 ssh2)
		$(use_enable nls)
		$(use_enable uim)
		$(use_enable scim)
		$(use_enable m17n-lib m17nlib)
		$(use_enable static-libs static)
	)

	if use gtk ; then
		myconf+="--with-imagelib=gdk-pixbuf"
	else
		myconf+="--with-tools=mlclient,mlcc"
	fi

	if use xft ; then
		myconf+="--with-type-engines=xft"
	else
		myconf+="--with-type-engines=xcore"
	fi

	# iiimf isn't stable enough
	#myconf="${myconf} $(use_enable iiimf)"

	autotools-utils_src_configure
}

src_install () {
	autotools-utils_src_install

	use static-libs || prune_libtool_files --all

	doicon contrib/icon/mlterm* || die
	make_desktop_entry mlterm mlterm mlterm-icon "System;TerminalEmulator" || die
}
