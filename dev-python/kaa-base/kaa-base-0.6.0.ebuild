# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-base/kaa-base-0.6.0.ebuild,v 1.9 2013/01/17 16:20:45 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="sqlite? threads(+)"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-*"

inherit distutils

DESCRIPTION="Basic Framework for all Kaa Python Modules."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="avahi ssl sqlite tls lirc"

DEPEND=">=dev-libs/glib-2.4.0
	avahi? ( net-dns/avahi[python] )
	sqlite? ( dev-python/dbus-python )"
RDEPEND="${DEPEND}
	dev-python/pynotifier
	lirc? ( dev-python/pylirc )
	tls? ( dev-python/tlslite )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="kaa"

src_prepare() {
	distutils_src_prepare

	sed -i -e 's:from pysqlite2 import dbapi2:import sqlite3:' \
		src/db.py || die

	rm -fr src/pynotifier
}
