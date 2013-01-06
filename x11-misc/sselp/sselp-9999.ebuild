# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sselp/sselp-9999.ebuild,v 1.3 2012/12/27 19:04:18 ottxor Exp $

inherit mercurial toolchain-funcs

DESCRIPTION="Simple X selection printer"
HOMEPAGE="http://tools.suckless.org/sselp"
SRC_URI=""
EHG_REPO_URI=http://code.suckless.org/hg/${PN}

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_unpack() {
	mercurial_src_unpack
	cd "${S}"

	sed -i \
		-e "s|^CFLAGS = -std=c99 -pedantic -Wall -Os|CFLAGS += -std=c99 -pedantic -Wall|" \
		-e "s|^LDFLAGS = -s|LDFLAGS +=|" \
		-e "s|^CC = cc|CC = $(tc-getCC)|" \
		config.mk || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README
}
