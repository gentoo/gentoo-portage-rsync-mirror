# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kffmpegthumbnailer/kffmpegthumbnailer-1.1.0-r2.ebuild,v 1.3 2012/11/14 20:36:49 johu Exp $

EAPI=4
inherit kde4-base

DESCRIPTION="A thumbnailer for KDE based on ffmpegthumbnailer"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer/"
SRC_URI="http://ffmpegthumbnailer.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="
	>=media-video/ffmpegthumbnailer-2
"
RDEPEND="${DEPEND}"

DOCS=( Changelog README )

src_prepare() {
	sed	-e  "/Encoding=UTF-8/d" \
		-i  kffmpegthumbnailer.desktop || die "fixing .desktop file failed"
	kde4-base_src_prepare
}
