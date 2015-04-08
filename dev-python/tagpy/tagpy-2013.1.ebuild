# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tagpy/tagpy-2013.1.ebuild,v 1.3 2015/03/31 04:26:20 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python Bindings for TagLib"
HOMEPAGE="http://mathema.tician.de//software/tagpy http://pypi.python.org/pypi/tagpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

RDEPEND=">=dev-libs/boost-1.49.0[python]
	>=media-libs/taglib-1.7.2"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DISTUTILS_IN_SOURCE_BUILD=1

python_configure() {
	"${PYTHON}" configure.py \
		--taglib-inc-dir="${EPREFIX}/usr/include/taglib" \
		--boost-python-libname="boost_python-${EPYTHON#python}"
	distutils-r1_python_configure
}

python_install_all() {
	use examples && local EXAMPLES=( test/* )

	distutils-r1_python_install_all
}
