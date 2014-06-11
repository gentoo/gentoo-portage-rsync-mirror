# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.7.4-r2.ebuild,v 1.1 2014/06/11 13:52:58 mgorny Exp $

EAPI=5

# For python3_{2,3}, see bugs 501338, 501340

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tgz"

LICENSE="GPL-2"
SLOT="0.7"
KEYWORDS="~amd64 ~hppa ~ia64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="!<${CATEGORY}/${PN}-0.6.18-r1:0
	dev-python/python-magic[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/paver[${PYTHON_USEDEP}]"

python_prepare_all() {
	# prevent the build system from installing unwrapped bash script
	sed -i -e '/scripts/d' pavement.py || die

	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install

	sed -e "s:python:${EPYTHON}:" bin/eyeD3 > "${TMPDIR}"/eyeD3 || die
	python_doexe "${TMPDIR}"/eyeD3
}

python_install_all() {
	dodoc AUTHORS ChangeLog README.rst
	distutils-r1_python_install_all
}
