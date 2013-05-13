# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/writerperfect/writerperfect-0.8.2.ebuild,v 1.1 2013/05/13 12:16:06 scarabeus Exp $

EAPI=5

DESCRIPTION="Various formats to Open document format converter"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/libwpd/${P}.tar.xz"

LICENSE="|| ( LGPL-2.1 MPL-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="+cdr debug gsf +mspub +mwaw +visio +wps"

RDEPEND="
	app-text/libwpd:0.9
	app-text/libwpg:0.2
	app-text/libodfgen
	wps? ( app-text/libwps )
	visio? ( media-libs/libvisio )
	gsf? ( gnome-extra/libgsf )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	econf \
		--disable-werror \
		$(use_enable debug) \
		$(use_with gsf libgsf) \
		$(use_with wps libwps) \
		$(use_with visio libvisio) \
		$(use_with cdr libcdr) \
		$(use_with mspub libmspub) \
		$(use_with mwaw libmwaw)
}
