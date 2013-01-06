# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libass/libass-0.9.11.ebuild,v 1.12 2012/05/05 08:02:29 jdhore Exp $

EAPI=3

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="http://code.google.com/p/libass/"
SRC_URI="http://libass.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+enca +fontconfig static-libs"

RDEPEND="fontconfig? ( >=media-libs/fontconfig-2.4.2 )
	>=media-libs/freetype-2.2.1
	virtual/libiconv
	enca? ( app-i18n/enca )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable enca) \
		$(use_enable fontconfig) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc Changelog

	find "${ED}" -name '*.la' -delete
}
