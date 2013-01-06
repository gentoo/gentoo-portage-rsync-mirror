# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr2jpeg/vdr2jpeg-0.1.9.ebuild,v 1.6 2012/05/05 08:58:50 jdhore Exp $

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
	epatch "${FILESDIR}/${P}-ffmpeg.patch"
}

src_install() {
	dobin vdr2jpeg
	dodoc README LIESMICH
}
