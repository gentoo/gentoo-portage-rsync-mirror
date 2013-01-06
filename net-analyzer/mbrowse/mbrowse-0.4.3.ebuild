# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mbrowse/mbrowse-0.4.3.ebuild,v 1.4 2012/09/28 06:43:42 pinkbyte Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="MBrowse is a graphical MIB browser"
HOMEPAGE="http://sourceforge.net/projects/mbrowse/"
SRC_URI="mirror://sourceforge/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="
	dev-libs/glib
	net-analyzer/net-snmp
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i acinclude.m4 \
		-e '/LDFLAGS=/d' \
		|| die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS README ChangeLog
}
