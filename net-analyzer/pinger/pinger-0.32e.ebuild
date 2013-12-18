# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pinger/pinger-0.32e.ebuild,v 1.3 2013/12/18 16:16:55 jer Exp $

EAPI=5

inherit autotools eutils flag-o-matic

DESCRIPTION="Cyclic multi ping utility for selected adresses using GTK/ncurses."
HOMEPAGE="http://aa.vslib.cz/silk/projekty/pinger/index.php"
SRC_URI="http://aa.vslib.cz/silk/projekty/pinger/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk nls"

RDEPEND="
	gtk? ( >=x11-libs/gtk+-2.4:2 )
	sys-libs/ncurses
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS BUGS ChangeLog NEWS README )

src_prepare() {
	# bug #494636
	cp "${FILESDIR}"/gtk-2.0.m4 m4/ || die

	epatch "${FILESDIR}"/${P}-tinfo.patch

	sed -i -e '/Root privileges/d' src/Makefile.am || die

	eautoreconf
}

src_configure() {
	append-cppflags -D_GNU_SOURCE

	econf $(use_enable gtk) $(use_enable nls)
}

src_install() {
	dobin src/pinger
}
