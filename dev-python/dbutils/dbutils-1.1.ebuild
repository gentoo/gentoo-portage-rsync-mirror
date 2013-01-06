# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbutils/dbutils-1.1.ebuild,v 1.2 2011/09/20 23:35:41 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="DBUtils"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Database connections for multi-threaded environments."
HOMEPAGE="http://www.webwareforpython.org/DBUtils http://pypi.python.org/pypi/DBUtils"
SRC_URI="http://www.webwareforpython.org/downloads/DBUtils/${MY_P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="doc"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"

src_prepare() {
	sed -i \
		-e "s/, 'DBUtils.Tests'//" \
		-e "s/, 'DBUtils.Examples'//" \
		-e "/package_data=/d" \
		setup.py || die "sed failed"
}

src_test() {
	python_execute_nosetests -- -P -s ${MY_PN}/Tests
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r "${S}/${MY_PN}"/Docs/* || die "dohtml failed"
		insinto "/usr/share/doc/${PF}/examples"
		doins "${S}/${MY_PN}"/Examples/*.py
	fi
}
