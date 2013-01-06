# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pinger/pinger-0.32d.ebuild,v 1.5 2012/05/04 06:08:11 jdhore Exp $

EAPI=2

inherit eutils flag-o-matic

DESCRIPTION="Cyclic multi ping utility for selected adresses using GTK/ncurses."
HOMEPAGE="http://aa.vslib.cz/silk/projekty/pinger/index.php"
SRC_URI="http://aa.vslib.cz/silk/projekty/pinger/download/${P}.tar.gz
		mirror://gentoo/gtk-2.0-for-pinger.m4.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="gtk nls"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.4:2 )
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	append-flags -D_GNU_SOURCE
	use nls || myconf="${myconf} --disable-nls"

	econf \
		$(use_enable gtk) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README

	use gtk || rm "${D}"/usr/bin/gtkpinger
}
