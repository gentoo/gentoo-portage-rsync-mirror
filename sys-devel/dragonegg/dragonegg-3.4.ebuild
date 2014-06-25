# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/dragonegg/dragonegg-3.4.ebuild,v 1.3 2014/06/25 17:41:10 voyageur Exp $

EAPI=5
inherit eutils multilib toolchain-funcs

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
	=sys-devel/llvm-${PV}*"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gcc-4.8.patch
}

src_compile() {
	# GCC: compiler to use plugin with
	emake CC="$(tc-getCC)" GCC="$(tc-getCC)" CXX="$(tc-getCXX)" VERBOSE=1
}

src_test() {
	# GCC languages are determined via locale-dependant gcc -v output
	export LC_ALL=C

	emake LIT_DIR="${WORKDIR}"/llvm-${PV}/utils/lit check
}

src_install() {
	exeinto /usr/$(get_libdir)
	doexe dragonegg.so

	dodoc README
}

pkg_postinst() {
	elog "To use dragonegg, run gcc as usual, with an extra command line argument:"
	elog "	-fplugin=/usr/$(get_libdir)/dragonegg.so"
	elog "If you change the active gcc profile, or update gcc to a new version,"
	elog "you will have to remerge this package to update the plugin"
}
