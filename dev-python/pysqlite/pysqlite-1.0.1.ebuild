# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-1.0.1.ebuild,v 1.13 2012/02/24 01:09:05 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Python wrapper for the local database Sqlite"
HOMEPAGE="http://pysqlite.org/"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"

LICENSE="pysqlite"
SLOT="0"
KEYWORDS="amd64 ~arm ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-db/sqlite:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="sqlite"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples || die
	doins -r examples/* || die
}
