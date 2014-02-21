# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mockldap/mockldap-0.1.5.ebuild,v 1.1 2014/02/21 08:52:14 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A simple mock implementation of python-ldap"
HOMEPAGE="https://bitbucket.org/psagers/mockldap/ https://pypi.python.org/pypi/mockldap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/funcparserlib[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/python-ldap[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/passlib[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${P}-modify_s-backport.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	if ! has_version dev-python/passlib; then
		elog "Please install dev-python/passlib for hashed password support."
	fi
}
