# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/coinor-utils/coinor-utils-2.9.11.ebuild,v 1.2 2014/01/15 20:00:22 bicatali Exp $

EAPI=5

inherit autotools-utils multilib toolchain-funcs

MYPN=CoinUtils

DESCRIPTION="COIN-OR Matrix, Vector and other utility classes"
HOMEPAGE="https://projects.coin-or.org/CoinUtils/"
SRC_URI="http://www.coin-or.org/download/source/${MYPN}/${MYPN}-${PV}.tgz"

LICENSE="EPL-1.0"
SLOT="0/3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="bzip2 doc glpk blas lapack static-libs test zlib"

RDEPEND="
	sys-libs/readline
	bzip2? ( app-arch/bzip2 )
	blas? ( virtual/blas )
	glpk? ( sci-mathematics/glpk:= )
	lapack? ( virtual/lapack )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen[dot] )
	test? ( sci-libs/coinor-sample )"

S="${WORKDIR}/${MYPN}-${PV}/${MYPN}"

src_configure() {
	local myeconfargs=(
		--enable-dependency-linking
		$(use_enable zlib)
		$(use_enable bzip2 bzlib)
		$(use_with doc dot)
	)
	if use blas; then
		myeconfargs+=( --with-blas-lib="$($(tc-getPKG_CONFIG) --libs blas)" )
	else
		myeconfargs+=( --without-blas )
	fi
	if use glpk; then
		myeconfargs+=(
			--with-glpk-incdir="${EPREFIX}"/usr/include
			--with-glpk-lib=-lglpk
		)
	else
		myeconfargs+=( --without-glpk )
	fi
	if use lapack; then
		myeconfargs+=( --with-lapack="$($(tc-getPKG_CONFIG) --libs lapack)" )
	else
		myeconfargs+=( --without-lapack )
	fi
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile all $(use doc && echo doxydoc)
}

psrc_test() {
	autotools-utils_src_test test
}

src_install() {
	use doc && HTML_DOC=("${BUILD_DIR}/doxydocs/html/")
	autotools-utils_src_install
	# already installed
	rm "${ED}"/usr/share/coin/doc/${MYPN}/{README,AUTHORS,LICENSE} || die
}
