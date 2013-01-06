# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.11.3d.ebuild,v 1.3 2012/08/03 15:32:02 hwoarang Exp $

EAPI=4
KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fr ga gl hr hu it
ja km ku lt lv mai nb nds nl nn pl pt pt_BR ro ru sk sr sr@latin sv th tr ug uk
zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://kmplayer.kde.org/pkgs/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2 LGPL-2.1"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="cairo debug expat handbook npp"

DEPEND="media-libs/phonon
	x11-libs/libX11
	expat? ( >=dev-libs/expat-2.0.1 )
	cairo? (
		x11-libs/cairo
		x11-libs/pango
	)
	npp? (
		dev-libs/dbus-glib
		>=x11-libs/gtk+-2.10.14:2
	)"
RDEPEND="${DEPEND}
	media-video/mplayer"

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	sed -e '/add_subdirectory(icons)/d' \
		-i CMakeLists.txt || die

	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use cairo KMPLAYER_BUILT_WITH_CAIRO)
		$(cmake-utils_use expat KMPLAYER_BUILT_WITH_EXPAT)
		$(cmake-utils_use npp KMPLAYER_BUILT_WITH_NPP)
	)

	kde4-base_src_configure
}
