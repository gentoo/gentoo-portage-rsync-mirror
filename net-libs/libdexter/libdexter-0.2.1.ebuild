# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libdexter/libdexter-0.2.1.ebuild,v 1.1 2013/01/17 17:37:20 pacho Exp $

EAPI=5
inherit gnome2-utils eutils

DESCRIPTION="A plugin-based, distributed sampling library"
HOMEPAGE="http://libdexter.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdexter/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnutls tcpd"

RDEPEND="gnutls? ( >=net-libs/gnutls-1.4.4:= )
	tcpd? ( sys-apps/tcp-wrappers:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-libs/glib-2.30:2"

src_prepare() {
	gnome2_disable_deprecation_warning
}

src_configure() {
	econf \
		$(use_enable tcpd tcp-wrappers) \
		$(use_enable gnutls tls)
}

src_install() {
	default
	prune_libtool_files --modules
}
