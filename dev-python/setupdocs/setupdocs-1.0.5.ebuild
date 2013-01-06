# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setupdocs/setupdocs-1.0.5.ebuild,v 1.6 2011/10/05 19:07:51 aballier Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="SetupDocs"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="setuptools plugin to automate building of docs from ReST source"
HOMEPAGE="http://pypi.python.org/pypi/SetupDocs http://code.enthought.com/projects/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND="dev-python/setuptools
	dev-python/sphinx
	virtual/latex-base
	dev-texlive/texlive-latexextra"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
