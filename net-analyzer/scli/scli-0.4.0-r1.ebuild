# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scli/scli-0.4.0-r1.ebuild,v 1.4 2012/11/20 20:11:09 ago Exp $

EAPI=4

inherit flag-o-matic toolchain-funcs

DESCRIPTION="SNMP Command Line Interface"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/scli/"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux"
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	net-libs/gnet
	net-libs/gsnmp
	sys-libs/ncurses
	sys-libs/readline
	sys-libs/zlib
	debug? ( dev-libs/dmalloc )
"
DEPEND="${RDEPEND}"

DOCS=( README AUTHORS NEWS TODO ChangeLog PORTING )

src_prepare() {
	sed -i stub/Makefile.in proc/Makefile.in \
		-e '/^AR = ar/d' || die
}

src_configure() {
	append-cppflags -I/usr/include/libxml2
	export AR=$(tc-getAR)
	econf \
		--enable-warnings \
		$(use_enable debug dmalloc)
}
