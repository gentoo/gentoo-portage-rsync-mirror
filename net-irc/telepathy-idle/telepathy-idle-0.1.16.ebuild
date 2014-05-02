# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/telepathy-idle/telepathy-idle-0.1.16.ebuild,v 1.10 2014/05/02 08:43:30 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit python-single-r1

DESCRIPTION="Full-featured IRC connection manager for Telepathy"
HOMEPAGE="http://cgit.freedesktop.org/telepathy/telepathy-idle"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 sparc x86 ~x86-linux"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	>=dev-libs/dbus-glib-0.51
	>=dev-libs/glib-2.30.0:2
	>=net-libs/telepathy-glib-0.15.9[${PYTHON_USEDEP}]
	sys-apps/dbus
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-python/twisted-words )
"
