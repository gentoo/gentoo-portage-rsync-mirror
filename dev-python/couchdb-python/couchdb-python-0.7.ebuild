# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/couchdb-python/couchdb-python-0.7.ebuild,v 1.6 2012/06/12 06:17:25 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="CouchDB"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library for working with CouchDB"
HOMEPAGE="http://code.google.com/p/couchdb-python/ http://pypi.python.org/pypi/CouchDB"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="dev-python/httplib2
	|| ( >=dev-lang/python-2.6
		( dev-lang/python:2.5 dev-python/simplejson ) )"
DEPEND="dev-python/setuptools"

S="${WORKDIR}/CouchDB-${PV}"

PYTHON_MODNAME="couchdb"

src_compile() {
	distutils_src_compile

#	if use doc; then
#		einfo "Generation of documentation"
#		epydoc --config=doc/conf/epydoc.ini || die "Generation of documentation failed"
#	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/api/* || die "Installation of documentation failed"
	fi
}
