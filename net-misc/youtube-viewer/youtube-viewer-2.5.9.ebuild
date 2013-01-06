# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-2.5.9.ebuild,v 1.4 2012/11/20 18:43:53 hasufell Exp $

EAPI=4

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.10.0
	dev-perl/libwww-perl
	dev-perl/XML-Fast
	|| ( media-video/mplayer[X,network]
		media-video/mplayer2[X,network] )"

S=${WORKDIR}

src_install() {
	newbin ${P} ${PN}
}
