# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tempita/tempita-0.5.2_pre20130828.ebuild,v 1.2 2014/03/31 21:07:37 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

MY_PN="tempita"
MY_PV="abe6a7282d363fa9136199dcaf04b2c0d501d4e6"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A very small text templating language"
HOMEPAGE="http://pythonpaste.org/tempita http://pypi.python.org/pypi/Tempita https://github.com/gjhiggins/tempita"
SRC_URI="https://github.com/gjhiggins/tempita/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests -w "${BUILD_DIR}" || die "Tests fail with ${EPYTHON}"
}
