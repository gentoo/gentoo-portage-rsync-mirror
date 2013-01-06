# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnapster/gnapster-1.5.0-r2.ebuild,v 1.16 2007/01/10 10:06:05 armin76 Exp $

IUSE="nls"

DESCRIPTION="A napster client for GTK/GNOME"
SRC_URI="mirror://sourceforge/gnapster/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gnapster/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	local myconf

	myconf="${myconf} --disable-gnome"
	myconf="${myconf} --disable-gdk-pixbuf --disable-gtktest"

	econf \
	$(use_enable nls) \
	${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS COPYING README* TODO NEWS
}
