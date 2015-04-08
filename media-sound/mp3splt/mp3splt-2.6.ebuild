# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-2.6.ebuild,v 1.6 2014/08/10 21:08:40 slyfox Exp $

EAPI=4
inherit multilib

DESCRIPTION="a command line utility to split mp3 and ogg files without decoding"
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ppc ~ppc64 sparc x86"
IUSE="flac"

RDEPEND="~media-libs/libmp3splt-0.9.0[flac?]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--enable-oggsplt_symlink \
		$(use_enable flac flacsplt_symlink) \
		--disable-dependency-tracking
}

src_install() {
	default
	dodoc AUTHORS ChangeLog NEWS README TODO
}
