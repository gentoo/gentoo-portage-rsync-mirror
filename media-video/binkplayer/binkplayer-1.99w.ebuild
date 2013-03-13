# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.99w.ebuild,v 1.1 2013/03/13 08:08:48 mr_bones_ Exp $

DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives and upstream has said they are not
# interested in providing versioned archives.
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
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
QA_EXECSTACK="opt/bin/BinkPlayer"

src_install() {
	into /opt
	dobin BinkPlayer || die
}
