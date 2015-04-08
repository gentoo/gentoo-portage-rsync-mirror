# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautomation/xautomation-1.05.ebuild,v 1.5 2012/05/05 17:41:22 armin76 Exp $

EAPI=4

DESCRIPTION="Control X from command line and find things on screen"
HOMEPAGE="http://hoopajoo.net/projects/xautomation.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""

RDEPEND="
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXtst
"
DEPEND="
	${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	x11-proto/xproto
"

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	export LIBS="-lX11"
}
