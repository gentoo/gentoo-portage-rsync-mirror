# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.9p.ebuild,v 1.5 2014/04/23 07:20:57 ulm Exp $

DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives and upstream has said they are not
# interested in providing versioned archives.
# SRC_URI="http://www.radgametools.com/down/Bink/BinkLinuxPlayer.zip"
SRC_URI="mirror://gentoo/${P}.zip"

# distributable per http://www.radgametools.com/binkfaq.htm
LICENSE="freedist"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-compat
	)
	x86? (
		media-libs/libsdl
		media-libs/sdl-mixer
		~virtual/libstdc++-3.3
	)"

S=${WORKDIR}

QA_FLAGS_IGNORED="opt/bin/BinkPlayer"
QA_PRESTRIPPED="opt/bin/BinkPlayer"

src_install() {
	into /opt
	dobin BinkPlayer || die
}
