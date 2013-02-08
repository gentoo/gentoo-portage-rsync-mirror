# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.1.9.ebuild,v 1.7 2013/02/08 21:39:04 aballier Exp $

EAPI=4

inherit eutils

VERSION="717" # every bump, new version

RESTRICT="strip"

DESCRIPTION="Addon needed for XXV - WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://projects.vdr-developer.org/projects/xxv"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz
		mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/ffmpeg"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e "s:usr/local:usr:" \
		-e "s:-o vdr2jpeg:\$(LDFLAGS) -o vdr2jpeg:" \
		Makefile || die
	epatch "${FILESDIR}/${P}-ffmpeg.patch" \
		"${FILESDIR}/${P}-ffmpeg1.patch"
}

src_install() {
	dobin vdr2jpeg
	dodoc README LIESMICH
}
