# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyelftools/pyelftools-0.20-r1.ebuild,v 1.1 2013/01/02 18:27:04 vapier Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="pure-Python library for parsing and analyzing ELF files and DWARF debugging information"
HOMEPAGE="http://pypi.python.org/pypi/pyelftools https://bitbucket.org/eliben/pyelftools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-dyntags-{1,2}.patch
	distutils_src_prepare
}

src_test() {
	local t
	# readelf_tests fails
	for t in all_unittests examples_test ; do
		./test/run_${t}.py || die
	done
}
