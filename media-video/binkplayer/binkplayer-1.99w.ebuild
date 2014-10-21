# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/binkplayer/binkplayer-1.99w.ebuild,v 1.7 2014/10/21 21:44:50 pacho Exp $

EAPI=5
DESCRIPTION="Bink Video! Player"
HOMEPAGE="http://www.radgametools.com/default.htm"
# No version on the archives and upstream has said they are not
# interested in providing versioned archives.
SRC_URI="mirror://gentoo/${P}.zip"

# distributable per http://www.radgametools.com/binkfaq.htm
LICENSE="freedist"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="
	virtual/libstdc++:3.3
	|| (
		(
			>=media-libs/libsdl-1.2.15-r5[abi_x86_32(-)]
			>=media-libs/sdl-mixer-1.2.12-r4[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
		)
	)
"

S=${WORKDIR}

QA_FLAGS_IGNORED="opt/bin/BinkPlayer"
QA_PRESTRIPPED="opt/bin/BinkPlayer"
QA_EXECSTACK="opt/bin/BinkPlayer"

src_install() {
	into /opt
	dobin BinkPlayer
}
