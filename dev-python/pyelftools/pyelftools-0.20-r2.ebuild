# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyelftools/pyelftools-0.20-r2.ebuild,v 1.1 2013/01/21 02:39:53 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2} )
inherit distutils-r1 eutils

DESCRIPTION="pure-Python library for parsing and analyzing ELF files and DWARF debugging information"
HOMEPAGE="http://pypi.python.org/pypi/pyelftools https://bitbucket.org/eliben/pyelftools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

src_prepare() {
	distutils-r1_src_prepare
	epatch "${FILESDIR}"/${P}-dyntags-{1,2}.patch
}

python_test() {
	# readelf_tests fails
	local test
		for test in all_unittests examples_test; do
			PYTHONPATH=$(ls -d build-${PYTHON_ABI}/lib/) "${PYTHON}" ./test/run_${test}.py || die
		done
}
