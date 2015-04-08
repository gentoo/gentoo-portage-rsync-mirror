# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libass/libass-0.9.13.ebuild,v 1.8 2012/05/05 08:02:29 jdhore Exp $

EAPI=4

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="http://code.google.com/p/libass/"
SRC_URI="http://libass.googlecode.com/files/${P}.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+enca +fontconfig static-libs"

RDEPEND="fontconfig? ( >=media-libs/fontconfig-2.4.2 )
	>=media-libs/freetype-2.2.1:2
	virtual/libiconv
	enca? ( app-i18n/enca )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="Changelog"

src_configure() {
	econf \
		$(use_enable enca) \
		$(use_enable fontconfig) \
		$(use_enable static-libs static)
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete
}
