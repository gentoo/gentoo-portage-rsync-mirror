# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.6-r3.ebuild,v 1.15 2014/03/31 20:26:16 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

MY_P="${P}-20050316"

DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm http://pypi.python.org/pypi/elementtree"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="ElementTree"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -e "s/distutils.core/setuptools/" -i setup.py || die "sed failed"
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" selftest.py || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local HTML_DOCS=( docs/. )
	distutils-r1_python_install_all
}
