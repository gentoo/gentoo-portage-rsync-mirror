# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/namebench/namebench-1.3.1-r1.ebuild,v 1.1 2013/08/03 08:25:33 pinkbyte Exp $

EAPI="5"

PYTHON_COMPAT=( python2_{5,6,7} )

inherit distutils-r1

DESCRIPTION="DNS Benchmark Utility"
HOMEPAGE="http://code.google.com/p/namebench/"
SRC_URI="http://namebench.googlecode.com/files/${P}-source.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

# PYTHON_REQ_USE does not support X? ( tk ) syntax yet
DEPEND="X? (
		python_targets_python2_5? ( dev-lang/python:2.5[tk] )
		python_targets_python2_6? ( dev-lang/python:2.6[tk] )
		python_targets_python2_7? ( dev-lang/python:2.7[tk] )
	)"
RDEPEND="${DEPEND}
	>=dev-python/dnspython-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.6[${PYTHON_USEDEP}]
	>=dev-python/graphy-1.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/simplejson-2.1.2[${PYTHON_USEDEP}]"

python_prepare_all() {
	# don't include bundled libraries
	export NO_THIRD_PARTY=1

	distutils-r1_python_prepare_all
}

python_install() {
	#set prefix
	distutils-r1_python_install --install-data=/usr/share
}

python_install_all() {
	dosym ${PN}.py /usr/bin/${PN}
	distutils-r1_python_install_all
}
