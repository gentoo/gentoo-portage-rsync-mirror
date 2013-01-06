# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-xml-rpc/flask-xml-rpc-0.1.2.ebuild,v 1.3 2011/10/08 17:49:02 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Flask-XML-RPC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="XML-RPC support for Flask applications."
HOMEPAGE="http://packages.python.org/Flask-XML-RPC/ http://pypi.python.org/pypi/Flask-XML-RPC"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/flask"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flaskext/xmlrpc.py"
