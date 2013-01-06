# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nethogs/nethogs-0.8.0-r2.ebuild,v 1.3 2012/01/28 15:07:08 phajdan.jr Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A small 'net top' tool, grouping bandwidth by process"
HOMEPAGE="http://nethogs.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE=""

RDEPEND="net-libs/libpcap
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i Makefile \
		-e '/^CFLAGS=/{s|=|+=|;s|-g||};/ -o /s|$(CFLAGS)|& $(LDFLAGS)|g' \
		-e 's|share/man/|usr/&|g' \
		-e 's|/sbin|/usr&|g' \
		|| die
	tc-export CC CXX
}

src_install() {
	default
	dodoc Changelog DESIGN README
}
