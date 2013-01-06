# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smplayer-themes/smplayer-themes-20120131.ebuild,v 1.4 2012/04/13 07:02:39 ago Exp $

EAPI=4

DESCRIPTION="Icon themes for smplayer"
HOMEPAGE="http://smplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/smplayer/${P}.tar.gz"

LICENSE="CCPL-Attribution-2.5 CCPL-Attribution-ShareAlike-2.5 CCPL-Attribution-ShareAlike-3.0 GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="media-video/smplayer"

# Override it as default will call make that will catch the install target...
src_compile() {
	:
}

src_install() {
	insinto /usr/share/smplayer
	doins -r themes
	dodoc Changelog README.txt
}
