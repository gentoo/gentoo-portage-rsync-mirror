# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/tribler/tribler-6.3.1.ebuild,v 1.1 2014/09/04 10:29:12 blueness Exp $

EAPI="5"

inherit eutils unpacker

DESCRIPTION="Bittorrent client that does not require a website to discover content"
HOMEPAGE="http://www.tribler.org/"
SRC_URI="
	https://github.com/Tribler/tribler/releases/download/v6.3.1/tribler_6.3.1_all.deb
	x86?   ( https://github.com/Tribler/tribler/releases/download/v6.3.1/tribler-swift_6.3.1_i386.deb )
	amd64? ( https://github.com/Tribler/tribler/releases/download/v6.3.1/tribler-swift_6.3.1_amd64.deb )"

LICENSE="GPL-2 LGPL-2.1+ PSF-2.4 openssl wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vlc"

RDEPEND="
	dev-lang/python:2.7[sqlite]
	dev-python/apsw
	dev-python/feedparser
	dev-python/m2crypto
	dev-python/netifaces
	dev-libs/openssl
	dev-python/wxpython
	net-libs/rb_libtorrent
	vlc? (
			media-video/vlc
			media-video/ffmpeg:0
		)"

DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

QA_PREBUILT="/usr/lib/tribler/swift"

src_prepare() {
	epatch "${FILESDIR}/${PN}-log2homedir.patch"
	epatch "${FILESDIR}/${PN}-6.2.0-fix-desktop.patch"
}

src_compile() { :; }

src_install() {
	#Remove the licenses scattered throughout
	rm usr/share/doc/${PN}-swift/copyright	# LGPL-2.1+
	rm usr/share/doc/${PN}/copyright	# LGPL-2.1+
	rm usr/share/${PN}/Tribler/binary-LICENSE-postfix.txt # GPL-2 LGPL-2.1+ PSF-2.4 openssl wxWinLL-3.1

	#Rename the doc dir properly
	mv usr/share/doc/${PN}-swift usr/share/doc/${PN}
	mv usr/share/doc/${PN} usr/share/doc/${P}

	#Move the readme to the doc dir
	mv usr/share/${PN}/Tribler/readme.txt usr/share/doc/${P}

	#Copy the rest over
	cp -pPR usr/ "${ED}"/
}
