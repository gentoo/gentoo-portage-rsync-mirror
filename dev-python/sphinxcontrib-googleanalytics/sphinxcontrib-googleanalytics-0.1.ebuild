# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinxcontrib-googleanalytics/sphinxcontrib-googleanalytics-0.1.ebuild,v 1.4 2012/10/12 07:04:45 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils eutils

DESCRIPTION="Sphinx extension googleanalytics"
HOMEPAGE="http://bitbucket.org/birkenfeld/sphinx-contrib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=">=dev-python/sphinx-0.6"

PYTHON_MODNAME="sphinxcontrib"

src_prepare() {
	epatch "${FILESDIR}/setup.py.utf-8.patch"
	distutils_src_prepare
}
