# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-haze/telepathy-haze-0.6.0.ebuild,v 1.7 2012/10/28 16:30:29 armin76 Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"

inherit python

DESCRIPTION="Telepathy connection manager providing libpurple supported protocols."
HOMEPAGE="http://developer.pidgin.im/wiki/TelepathyHaze"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
#IUSE="test"
IUSE=""

# Tests failing, see upstream: https://bugs.freedesktop.org/34577
RESTRICT="test"

RDEPEND=">=net-im/pidgin-2.7
	>=net-libs/telepathy-glib-0.15.1
	>=dev-libs/glib-2.22:2
	>=dev-libs/dbus-glib-0.73"

DEPEND="${RDEPEND}
	virtual/pkgconfig"
#	test? ( dev-python/twisted-words )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}
