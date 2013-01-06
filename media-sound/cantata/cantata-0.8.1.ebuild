# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantata/cantata-0.8.1.ebuild,v 1.1 2012/07/26 22:10:34 johu Exp $

EAPI=4

KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Cantata is a client for the music player daemon (MPD)"
HOMEPAGE="http://kde-apps.org/content/show.php?content=147733"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

DEPEND="
	media-libs/speex
	media-libs/taglib
	media-libs/taglib-extras
	media-sound/mpg123
	virtual/ffmpeg
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_want kde KDE_SUPPORT)
	)

	kde4-base_src_configure
}
