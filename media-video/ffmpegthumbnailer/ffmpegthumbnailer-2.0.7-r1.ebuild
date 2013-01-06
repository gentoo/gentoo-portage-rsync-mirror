# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpegthumbnailer/ffmpegthumbnailer-2.0.7-r1.ebuild,v 1.8 2012/08/05 18:09:47 armin76 Exp $

EAPI=4
inherit eutils

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="gtk jpeg png"

COMMON_DEPEND=">=virtual/ffmpeg-0.10.2
	png? ( >=media-libs/libpng-1.2:0 )
	jpeg? ( virtual/jpeg )"
RDEPEND="${COMMON_DEPEND}
	gtk? ( >=dev-libs/glib-2.14 )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-r238-r241.patch
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable png) \
		$(use_enable jpeg) \
		$(use_enable gtk gio)
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
