# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-rakia/telepathy-rakia-0.7.4.ebuild,v 1.6 2013/03/26 16:54:08 ago Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit autotools eutils python

DESCRIPTION="A SIP connection manager for Telepathy based around the Sofia-SIP library"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~x86-linux"
IUSE="test"

COMMON_DEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.30:2
	>=net-libs/sofia-sip-1.12.11
	>=net-libs/telepathy-glib-0.17.6
	>=dev-libs/glib-2.30:2
	sys-apps/dbus"
RDEPEND="${COMMON_DEPEND}
	!net-voip/telepathy-sofiasip"
# telepathy-rakia was formerly known as telepathy-sofiasip
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	test? ( dev-python/twisted )
	dev-util/gtk-doc-am"
# eautoreconf requires: gtk-doc-am

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gio-linking.patch"
	eautoreconf
	python_convert_shebangs -r 2 .
}
