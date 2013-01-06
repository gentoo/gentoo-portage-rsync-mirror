# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decoratortools/decoratortools-1.8.ebuild,v 1.6 2011/09/05 04:58:24 neurogeek Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="DecoratorTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Class, function, and metaclass decorators"
HOMEPAGE="http://pypi.python.org/pypi/DecoratorTools"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="|| ( PSF-2 ZPL )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="peak"

src_prepare() {
	distutils_src_prepare

	# Disable tests broken with named tuples.
	sed -e "s/additional_tests/_&/" -i test_decorators.py || die "sed failed"
}
