# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcss/libcss-0.1.2.ebuild,v 1.8 2013/02/27 09:48:29 xmw Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="CSS parser and selection engine, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libcss/"
SRC_URI="http://download.netsurf-browser.org/libs/releases/libcss-0.1.2-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="debug static-libs test"

RDEPEND="dev-libs/libparserutils
	dev-libs/libwapcaplet"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-lang/perl )"

pkg_setup(){
	netsurf_src_prepare() {
		sed -e "/^CCOPT :=/s:=.*:=:" \
			-e "/^CCNOOPT :=/s:=.*:=:" \
			-e "/^CCDBG :=/s:=.*:=:" \
			-i build/makefiles/Makefile.{gcc,clang} || die
		sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
			-i Makefile || die
		sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
			-i ${PN}.pc.in || die
	}
	netsurf_src_configure() {
		echo "Q := " >> Makefile.config
		echo "CC := $(tc-getCC)" >> Makefile.config
		echo "AR := $(tc-getAR)" >> Makefile.config
	}

	netsurf_make() {
		emake COMPONENT_TYPE=lib-shared BUILD=$(usex debug debug release) "$@"
		use static-libs && \
			emake COMPONENT_TYPE=lib-static BUILD=$(usex debug debug release) "$@"
	}
}

src_prepare() {
	netsurf_src_prepare

	sed -e 's/x86_64-pc-linux-gnu-gcc/$(CC)/' \
		-i src/parse/properties/Makefile || die

	epatch "${FILESDIR}"/${P}-enum-compare.patch
}

src_configure() {
	netsurf_src_configure
}

src_compile() {
	netsurf_make
}

src_test() {
	netsurf_make test
}

src_install() {
	netsurf_make DESTDIR="${D}" PREFIX=/usr install

	dodoc README
}
