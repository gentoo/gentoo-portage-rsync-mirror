# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gunicorn/gunicorn-0.15.0.ebuild,v 1.3 2012/11/27 13:04:55 ago Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="A WSGI HTTP Server for UNIX"
HOMEPAGE="http://gunicorn.org http://pypi.python.org/pypi/gunicorn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="test"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/setproctitle"
DEPEND="dev-python/setuptools"

DOCS="README.rst"

src_prepare() {
	epatch "${FILESDIR}/${PN}"-0.14.0-noegg.patch || die
}
