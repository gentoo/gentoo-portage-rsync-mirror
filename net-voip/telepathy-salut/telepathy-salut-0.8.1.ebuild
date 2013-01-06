# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-salut/telepathy-salut-0.8.1.ebuild,v 1.2 2012/12/31 15:54:42 ago Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"

inherit base python eutils

DESCRIPTION="A link-local XMPP connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/CategorySalut"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
IUSE="test"

RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2.24:2
	>=sys-apps/dbus-1.1.0
	>=net-libs/telepathy-glib-0.17.1
	>=net-dns/avahi-0.6.22[dbus]
	net-libs/libsoup:2.4
	sys-apps/util-linux"
DEPEND="${RDEPEND}
	test? (
		>=dev-libs/check-0.9.4
		net-libs/libgsasl
		dev-python/twisted-words )
	dev-libs/libxslt
	virtual/pkgconfig"
# FIXME: needs xmppstream python module
#               >=net-dns/avahi-0.6.22[python]

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Fix uninitialized variable, upstream bug #37701
	epatch "${FILESDIR}/${PN}-0.5.0-uninitialized.patch"

	python_convert_shebangs -r 2 .
}

src_configure() {
	econf \
		--disable-plugins \
		--disable-Werror \
		--disable-static \
		--disable-avahi-tests \
		--docdir=/usr/share/doc/${PF}
		#$(use_enable test avahi-tests)
}

src_install() {
	MAKEOPTS+=" -j1" default # bug 413581
	prune_libtool_files
}
