# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pogo/pogo-2.2-r1.ebuild,v 1.2 2010/11/08 12:42:35 nelchael Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Pogo is a neat launcher program for X"
SRC_URI="mirror://gentoo/${P}.tar.gz"
# upstream no longer exists
HOMEPAGE="http://packages.gentoo.org/package/x11-misc/pogo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	media-libs/imlib
	virtual/jpeg
	>=sys-apps/sed-4"

src_prepare() {
	cp "${FILESDIR}"/Makefile-r1 Makefile || die
	sed -i -e "s:/usr/local:/usr/share:g" configs/* pogo.c || die
}

src_compile() {
	emake clean || die
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README || die
}
