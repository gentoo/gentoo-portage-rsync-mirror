# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.10-r3.ebuild,v 1.7 2012/06/17 18:36:19 armin76 Exp $

EAPI=4

inherit eutils flag-o-matic

DESCRIPTION="Hypertext info and man viewer based on (n)curses"
HOMEPAGE="http://pinfo.alioth.debian.org/"
SRC_URI="https://alioth.debian.org/frs/download.php/3351/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="nls readline"

RDEPEND="
	sys-libs/ncurses
	nls? ( virtual/libintl )
"

DEPEND="
	${RDEPEND}
	sys-devel/bison
	nls? ( sys-devel/gettext )
"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.6.9-as-needed.patch \
		"${FILESDIR}"/${PN}-0.6.9-GROFF_NO_SGR.patch \
		"${FILESDIR}"/${PN}-0.6.9-lzma-xz.patch \
		"${FILESDIR}"/${P}-version.patch \
		"${FILESDIR}"/${P}-info-suffix.patch \
		"${FILESDIR}"/${P}-dir-file.patch

	# autoconf does not work as expected
	./autogen.sh || die

	append-cflags -D_BSD_SOURCE # sbrk()
}

src_configure() {
	econf $(use_with readline) $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" sysconfdir=/etc install
}
