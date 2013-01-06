# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpegoptim/jpegoptim-1.2.4.ebuild,v 1.3 2011/06/19 13:51:25 maekke Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Utility to optimize JPEG files"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html"
SRC_URI="http://www.kokkonen.net/tjko/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="virtual/jpeg"
DEPEND="${RDEPEND}"

src_configure() {
	tc-export CC
	econf
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc README
}
