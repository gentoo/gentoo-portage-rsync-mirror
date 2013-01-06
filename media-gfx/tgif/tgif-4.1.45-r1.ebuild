# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tgif/tgif-4.1.45-r1.ebuild,v 1.3 2010/02/21 04:24:52 abcd Exp $

EAPI=3

inherit eutils toolchain-funcs

MY_P="${PN}-QPL-${PV}"

DESCRIPTION="Tgif is an Xlib base 2-D drawing facility under X11."
HOMEPAGE="http://bourbon.usc.edu/tgif/index.html"
SRC_URI="ftp://bourbon.usc.edu/pub/${PN}/${MY_P}.tar.gz"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="x11-libs/libX11
	x11-proto/xproto"
RDEPEND="${DEPEND}
	media-libs/netpbm"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-sym.patch"
	sed -i \
		-e '/^INSTPGMFLAGS/d' \
		-e 's/#prtgif /prtgif #/' \
		-e "/LDFLAGS/ s:=:+=:" \
		Makefile.noimake || die "sed failed"
}

src_compile() {
	emake -f Makefile.noimake \
		CC=$(tc-getCC) CPPFLAGS="${CFLAGS}" TGIFDIR="${EPREFIX}/usr/bin/tgif" \
		|| die "emake failed"
}

src_install() {
	emake -f Makefile.noimake CC=$(tc-getCC) DESTDIR="${ED}" install \
		|| die "emake install failed"

	## example-files
	dodoc tgif.Xdefaults tgificon.eps tgificon.obj \
		tgificon.xbm tgificon.xpm tangram.sym eq4.sym eq4-2x.sym \
		eq4-ps2epsi.sym eq4-epstool.sym eq4xpm.sym \
		eq4-lyx-ps2epsi.sym keys.obj

	dodoc README HISTORY
}
