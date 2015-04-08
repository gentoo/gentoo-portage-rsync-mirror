# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymssql/pymssql-1.0.2-r1.ebuild,v 1.12 2014/03/31 21:19:31 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Simple MSSQL python extension module"
HOMEPAGE="http://pymssql.sourceforge.net/ http://code.google.com/p/pymssql/ http://pypi.python.org/pypi/pymssql"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

DEPEND=">=dev-db/freetds-0.63[mssql]
	dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

python_configure_all() {
	append-flags -fno-strict-aliasing
}
