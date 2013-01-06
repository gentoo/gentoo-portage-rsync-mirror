# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/dragonegg/dragonegg-3.2.ebuild,v 1.1 2012/12/21 09:18:50 voyageur Exp $

EAPI=5
inherit multilib toolchain-funcs

DESCRIPTION="GCC plugin that uses LLVM for optimization and code generation"
HOMEPAGE="http://dragonegg.llvm.org/"
SRC_URI="http://llvm.org/releases/${PV}/${P}.src.tar.gz
	test? ( http://llvm.org/releases/${PV}/llvm-${PV}.src.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="test"

DEPEND="|| ( sys-devel/gcc:4.5[lto]
		>=sys-devel/gcc-4.6 )
	~sys-devel/llvm-${PV}"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}.src

src_compile() {
	# GCC: compiler to use plugin with
	emake CC="$(tc-getCC)" GCC="$(tc-getCC)" CXX="$(tc-getCXX)" VERBOSE=1
}

src_test() {
	# GCC languages are determined via locale-dependant gcc -v output
	export LC_ALL=C

	emake LIT_DIR="${WORKDIR}"/llvm-${PV}.src/utils/lit check
}

src_install() {
	# Install plugin in llvm lib directory
	exeinto /usr/$(get_libdir)/llvm
	doexe dragonegg.so

	dodoc README
}

pkg_postinst() {
	elog "To use dragonegg, run gcc as usual, with an extra command line argument:"
	elog "	-fplugin=/usr/$(get_libdir)/llvm/dragonegg.so"
	elog "If you change the active gcc profile, or update gcc to a new version,"
	elog "you will have to remerge this package to update the plugin"
}
