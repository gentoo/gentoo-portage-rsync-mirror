# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/coinor-bcp/coinor-bcp-1.3.8.ebuild,v 1.1 2014/01/14 21:47:05 bicatali Exp $

EAPI=5

inherit autotools-utils multilib

MYPN=Bcp

DESCRIPTION="COIN-OR Branch-Cut-Price Framework"
HOMEPAGE="https://projects.coin-or.org/Bcp/"
SRC_URI="http://www.coin-or.org/download/source/${MYPN}/${MYPN}-${PV}.tgz"

LICENSE="EPL-1.0"
SLOT="0/1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs test"

RDEPEND="
	sci-libs/coinor-cgl:=
	sci-libs/coinor-clp:=
	sci-libs/coinor-vol:="
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( sci-libs/coinor-sample )"

S="${WORKDIR}/${MYPN}-${PV}/${MYPN}"

src_prepare() {
	# as-needed fix
	# hack to avoid eautoreconf (coinor has its own weird autotools)
	sed -i \
		-e 's:\(libBcp_la_LIBADD.*=\).*:\1 @BCPLIB_LIBS@:g' \
		src/Makefile.in || die
}

src_configure() {
	PKG_CONFIG_PATH+="${ED}"/usr/$(get_libdir)/pkgconfig \
		autotools-utils_src_configure
}

src_test() {
	pushd "${BUILD_DIR}" > /dev/null || die
	emake test
	popd > /dev/null || die
}

src_install() {
	autotools-utils_src_install
	use doc && newdoc doc/man.pdf manual.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
