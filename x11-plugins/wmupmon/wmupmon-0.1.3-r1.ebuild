# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmupmon/wmupmon-0.1.3-r1.ebuild,v 1.8 2008/11/26 00:10:12 tcunha Exp $

inherit eutils

DESCRIPTION="wmUpMon is a program to monitor your Uptime"
HOMEPAGE="http://j-z-s.com/projects/index.php?project=wmupmon"
SRC_URI="http://j-z-s.com/projects/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-arraysize.patch
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS README THANKS ChangeLog
}
