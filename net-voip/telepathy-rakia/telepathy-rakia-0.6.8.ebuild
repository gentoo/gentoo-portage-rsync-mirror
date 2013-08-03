# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-rakia/telepathy-rakia-0.6.8.ebuild,v 1.2 2013/08/03 09:45:49 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A SIP connection manager for Telepathy based around the Sofia-SIP library"
HOMEPAGE="http://telepathy.freedesktop.org/"
MY_PN="telepathy-sofiasip"
MY_P="${MY_PN}-${PV}"
SRC_URI="http://telepathy.freedesktop.org/releases/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-linux"
IUSE="test"

COMMON_DEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.16:2
	>=net-libs/sofia-sip-1.12.11
	>=net-libs/telepathy-glib-0.8.0
	sys-apps/dbus"
RDEPEND="${COMMON_DEPEND}
	!net-voip/telepathy-sofiasip"
# telepathy-rakia was formerly known as telepathy-sofiasip
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	test? ( dev-python/twisted-core )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}
