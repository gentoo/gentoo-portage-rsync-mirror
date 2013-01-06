# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paver/paver-1.0.4.ebuild,v 1.3 2011/05/15 16:30:39 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="${PN/p/P}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python-based software project scripting tool along the lines of Make"
HOMEPAGE="http://www.blueskyonmars.com/projects/paver/ http://pypi.python.org/pypi/Paver"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="README.txt"
