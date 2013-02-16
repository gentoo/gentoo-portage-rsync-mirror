# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.7.50.ebuild,v 1.1 2013/02/16 02:32:01 radhermit Exp $

EAPI=5

MY_P=${P}-nolib

inherit toolchain-funcs

DESCRIPTION="Portable Network Graphics (PNG) optimizing utility"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
SRC_URI="mirror://sourceforge/pmt/${MY_P}.tar.xz"

LICENSE="pngcrush"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=media-libs/libpng-1.4:0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	dohtml ChangeLog.html
}
