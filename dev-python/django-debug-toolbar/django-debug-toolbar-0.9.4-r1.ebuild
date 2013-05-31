# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-debug-toolbar/django-debug-toolbar-0.9.4-r1.ebuild,v 1.2 2013/05/31 03:22:29 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A configurable set of panels that display debug information"
HOMEPAGE="http://pypi.python.org/pypi/django-debug-toolbar/
	https://github.com/django-debug-toolbar/django-debug-toolbar/"
SRC_URI="https://github.com/django-debug-toolbar/django-debug-toolbar/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="test"

LICENSE="MIT"
SLOT="0"
DISTUTILS_IN_SOURCE_BUILD=1

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (	dev-python/dingus[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" runtests.py || die "Tests failed with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install
	#rm all OSX fork files, Bug #450880
	pushd "${ED}" > /dev/null
	rm -f $(find . -name "._*")
}
