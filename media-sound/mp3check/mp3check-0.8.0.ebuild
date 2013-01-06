# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.0.ebuild,v 1.9 2012/02/05 15:10:38 armin76 Exp $

EAPI=2
inherit eutils

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings."
HOMEPAGE="http://jo.ath.cx/soft/mp3check/mp3check.html"
SRC_URI="http://jo.ath.cx/soft/mp3check/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc34.diff
}

src_install() {
	einstall || die "einstall failed"
	dodoc ChangeLog FAQ HISTORY THANKS TODO
}
