# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.1.0_p20130921.ebuild,v 1.2 2015/04/08 08:04:56 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="An LDAP database backend for Django"
HOMEPAGE="https://github.com/jlaine/django-ldapdb"
SRC_URI="http://dev.gentoo.org/~tampakrap/tarballs/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="examples test"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/python-ldap[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mockldap[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}"

python_test() {
	esetup.py test
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
