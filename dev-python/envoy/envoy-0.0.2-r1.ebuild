# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envoy/envoy-0.0.2-r1.ebuild,v 1.1 2013/06/05 19:18:34 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Simple API for running external processes"
HOMEPAGE="https://github.com/kennethreitz/envoy http://pypi.python.org/pypi/envoy"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

# Upstream forgot test_envoy.py in manifest. https://github.com/kennethreitz/envoy/pull/11
# that was a year ago
python_prepare_all() {
	cp -r "${FILESDIR}"/test_envoy.py . || die
	distutils-r1_python_prepare_all
}

python_test() {
	# and it fails almost all;https://github.com/kennethreitz/envoy/issues/58
	"${PYTHON}" test_envoy.py
}
