# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xchm/xchm-1.20.ebuild,v 1.5 2012/09/18 11:56:56 johu Exp $

EAPI="4"

WX_GTK_VER="2.8"

inherit eutils wxwidgets flag-o-matic fdo-mime gnome2-utils

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://xchm.sf.net"
SRC_URI="mirror://sourceforge/xchm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="nls"
DEPEND=">=dev-libs/chmlib-0.36
	x11-libs/wxGTK:2.8[X]"
RDEPEND=${DEPEND}

src_configure() {
	append-flags -fno-strict-aliasing
	econf ${myconf} \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS README ChangeLog

	cp "${D}"/usr/share/pixmaps/xchm-32.xpm "${D}"/usr/share/pixmaps/xchm.xpm
	rm -f "${D}"/usr/share/pixmaps/xchm-*.xpm
	rm -f "${D}"/usr/share/pixmaps/xchmdoc*.xpm

	domenu "${FILESDIR}"/xchm.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/xchm.xml
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
