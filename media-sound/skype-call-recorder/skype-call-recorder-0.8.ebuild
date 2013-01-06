# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/skype-call-recorder/skype-call-recorder-0.8.ebuild,v 1.2 2012/12/04 22:06:32 reavertm Exp $

EAPI="4"

inherit cmake-utils

DESCRIPTION="Records Skype calls to MP3/Ogg/WAV files"
HOMEPAGE="http://atdot.ch/scr/"
SRC_URI="http://atdot.ch/scr/files/${PV}/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	media-libs/id3lib
	>=media-libs/libogg-1.2.0
	>=media-libs/libvorbis-1.2.0
	media-sound/lame
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-dbus-4.4:4
	>=x11-libs/qt-gui-4.4:4[dbus]
"
RDEPEND="${DEPEND}
	net-im/skype[-qt-static(-)]
"

PATCHES=(
	"${FILESDIR}/${P}-cmake.patch"
)
