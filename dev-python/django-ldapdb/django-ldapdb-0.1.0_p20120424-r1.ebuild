# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.1.0_p20120424-r1.ebuild,v 1.1 2013/07/12 14:56:09 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="An LDAP database backend for Django"
HOMEPAGE="https://github.com/jlaine/django-ldapdb"
SRC_URI="http://dev.gentoo.org/~tampakrap/tarballs/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="examples"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

# Tests require LDAP setup.
RESTRICT=test
