# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-base/kaa-base-0.6.0.ebuild,v 1.8 2012/08/02 22:06:12 neurogeek Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="threads(+)"
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
	sqlite? ( dev-python/dbus-python >=dev-python/pysqlite-2.3.0 )"
RDEPEND="${DEPEND}
	dev-python/pynotifier
	lirc? ( dev-python/pylirc )
	tls? ( dev-python/tlslite )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="kaa"

src_prepare() {
	distutils_src_prepare

	rm -fr src/pynotifier
}
