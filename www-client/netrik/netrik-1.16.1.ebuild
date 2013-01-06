# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/netrik/netrik-1.16.1.ebuild,v 1.3 2012/08/04 13:39:29 ago Exp $

EAPI=4

DESCRIPTION="A text based web browser with no ssl support."
HOMEPAGE="http://netrik.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.1
	sys-libs/readline"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "/^doc_DATA/s/LICENSE//" \
		-e "/^CFLAGS =/d" \
		-i Makefile.in || die
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install
}
