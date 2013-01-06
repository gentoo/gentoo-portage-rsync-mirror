# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paisley/paisley-0.3.1.ebuild,v 1.4 2011/06/24 18:54:35 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Paisley is a CouchDB client written in Python to be used within a Twisted application."
HOMEPAGE="http://launchpad.net/paisley http://pypi.python.org/pypi/paisley"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-python/simplejson
	dev-python/twisted
	dev-python/twisted-web"
DEPEND="${RDEPEND}"
