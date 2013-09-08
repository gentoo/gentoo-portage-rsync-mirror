# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mockldap/mockldap-0.1.ebuild,v 1.1 2013/09/08 10:11:10 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A simple mock implementation of python-ldap"
HOMEPAGE="https://bitbucket.org/psagers/mockldap/ https://pypi.python.org/pypi/mockldap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/funcparserlib[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/python-ldap[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/passlib[${PYTHON_USEDEP}] )"

python_test() {
	esetup.py test
}

pkg_postinst() {
	if ! has_version dev-python/passlib; then
		elog "Please install dev-python/passlib for hashed password support."
	fi
}
