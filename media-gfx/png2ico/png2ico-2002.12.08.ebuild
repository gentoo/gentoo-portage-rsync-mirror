# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/png2ico/png2ico-2002.12.08.ebuild,v 1.1 2011/10/09 09:04:00 ssuominen Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="PNG to icon converter"
HOMEPAGE="http://winterdrache.de/freeware/png2ico/index.html"
SRC_URI="http://winterdrache.de/freeware/${PN}/data/${PN}-src-${PV/./-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e 's:CPPFLAGS=-W -Wall -O2:CXXFLAGS+=-W -Wall:' \
		-e 's:g++ $(CPPFLAGS):$(CXX) $(LDFLAGS) $(CXXFLAGS):' \
		Makefile || die
}

src_compile() {
	tc-export CXX
	emake DEBUG=""
}

src_install() {
	dobin png2ico
	dodoc doc/bmp.txt README
	doman doc/png2ico.1
}
