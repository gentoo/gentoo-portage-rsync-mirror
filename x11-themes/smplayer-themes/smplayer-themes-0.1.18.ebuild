# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smplayer-themes/smplayer-themes-0.1.18.ebuild,v 1.6 2009/04/13 21:32:20 ranger Exp $

DESCRIPTION="Icon themes for smplayer"
HOMEPAGE="http://smplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/smplayer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="media-video/smplayer"

# Override it as default will call make that will catch the install target...
src_compile() {
	return
}

src_install() {
	insinto /usr/share/smplayer
	doins -r themes || die "Failed to install themes"
	dodoc Changelog README.txt
}
