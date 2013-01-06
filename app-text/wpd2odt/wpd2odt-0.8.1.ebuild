# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wpd2odt/wpd2odt-0.8.1.ebuild,v 1.6 2012/05/04 03:33:16 jdhore Exp $

EAPI=4

DESCRIPTION="WordPerfect Document (wpd/wpg) to Open document (odt/odg) converter"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/libwpd/writerperfect-${PV}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="debug gsf +visio +wpg +wps"

RDEPEND="
	app-text/libwpd:0.9
	wpg? ( app-text/libwpg:0.2 )
	wps? ( app-text/libwps )
	visio? ( media-libs/libvisio )
	gsf? ( gnome-extra/libgsf )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S=${WORKDIR}/writerperfect-${PV}

src_configure() {
	econf \
		--disable-werror \
		$(use_enable debug) \
		$(use_with gsf libgsf) \
		$(use_with wpg libwpg) \
		$(use_with wps libwps) \
		$(use_with visio libvisio)
}
