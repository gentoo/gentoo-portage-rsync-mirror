# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/marisa/marisa-0.2.4.ebuild,v 1.1 2014/08/22 02:45:53 dlan Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )
DISTUTILS_OPTIONAL=1

inherit distutils-r1 eutils

DESCRIPTION="Matching Algorithm with Recursively Implemented StorAge"
HOMEPAGE="https://code.google.com/p/marisa-trie/"
SRC_URI="https://marisa-trie.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python doc static-libs sse2 sse3 ssse3 sse4.1 sse4.2 sse4 sse4a popcnt"

DEPEND="python? ( dev-lang/swig ${PYTHON_DEPS} )"
RDEPEND="python? ( ${PYTHON_DEPS} )"

src_prepare() {
	epatch "${FILESDIR}/${P}-python.patch"
	if use python; then
		pushd bindings/python
		ln -sf ../marisa-swig.i marisa-swig.i
		ln -sf ../marisa-swig.h marisa-swig.h
		ln -sf ../marisa-swig.cxx marisa-swig.cxx
		distutils-r1_src_prepare
		popd
	fi
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_enable sse2)
		$(use_enable sse3)
		$(use_enable ssse3)
		$(use_enable sse4.1)
		$(use_enable sse4.2)
		$(use_enable sse4)
		$(use_enable sse4a)
		$(use_enable popcnt)
	)
	econf "${myeconfargs[@]}"

	if use python; then
		pushd bindings/python
		distutils-r1_src_prepare
		popd
	fi
}

src_compile() {
	default
	if use python; then
		pushd bindings/python
		distutils-r1_src_compile
		popd
	fi
}

src_install() {
	default
	if use python; then
		pushd bindings/python
		distutils-r1_src_install
		popd
	fi
	use doc && dohtml docs/readme.en.html
	prune_libtool_files
}
