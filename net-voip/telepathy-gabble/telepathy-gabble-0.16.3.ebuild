# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.16.3.ebuild,v 1.1 2012/09/15 08:03:49 pacho Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"

inherit python eutils

DESCRIPTION="A Jabber/XMPP connection manager, this handles single and multi user chats and voice calls."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
IUSE="+jingle test"

RDEPEND=">=dev-libs/glib-2.30:2
	>=sys-apps/dbus-1.1.0
	>=dev-libs/dbus-glib-0.82
	>=net-libs/telepathy-glib-0.18
	>=net-libs/libnice-0.0.11
	>=net-libs/gnutls-2.10.2

	dev-db/sqlite:3
	dev-libs/libxml2

	jingle? ( || ( net-libs/libsoup:2.4[ssl]
		 >=net-libs/libsoup-2.33.1 ) )

	!<net-im/telepathy-mission-control-5.5.0"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	test? ( >=dev-python/twisted-0.8.2
		>=dev-python/twisted-words-0.8.2
		>=dev-python/dbus-python-0.83 )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--disable-coding-style-checks \
		--disable-Werror \
		$(use_enable jingle file-transfer)
}

src_test() {
	# Twisted tests fail, upstream bug #30565
	emake -C tests check-TESTS
}

src_install() {
	default
	prune_libtool_files
}
