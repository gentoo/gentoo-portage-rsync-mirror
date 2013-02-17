# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/couchdb-python/couchdb-python-0.8-r1.ebuild,v 1.1 2013/02/17 13:42:51 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

MY_PN="CouchDB"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library for working with CouchDB"
HOMEPAGE="http://code.google.com/p/couchdb-python/ http://pypi.python.org/pypi/CouchDB"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/httplib2[${PYTHON_USEDEP}]
	virtual/python-json[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}

# Tests require connectivity to a couchdb server.
# Re-enable when the ebuild is capable of starting a local couchdb
# instance.
RESTRICT=test

python_test() {
	esetup.py test
}
