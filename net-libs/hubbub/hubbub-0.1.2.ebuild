# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/hubbub/hubbub-0.1.2.ebuild,v 1.4 2013/02/28 07:28:03 xmw Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="HTML5 compliant parsing library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/hubbub/"
SRC_URI="http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="debug doc static-libs test"

RDEPEND="dev-libs/libparserutils"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	virtual/libiconv
	doc? ( app-doc/doxygen )
	test? ( dev-lang/perl
		dev-libs/json-c )"

RESTRICT=test

pkg_setup(){
	netsurf_src_prepare() {
		sed -e "/^CCOPT :=/s:=.*:=:" \
			-e "/^CCNOOPT :=/s:=.*:=:" \
			-e "/^CCDBG :=/s:=.*:=:" \
			-i build/makefiles/Makefile.{gcc,clang} || die
		sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
			-i Makefile || die
		sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
			-i ${NETSURF_PKGCONFIG:-${PN}}.pc.in || die
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
	NETSURF_PKGCONFIG=lib${PN}
	netsurf_src_prepare

	epatch "${FILESDIR}"/${P}-error.patch
}

src_configure() {
	netsurf_src_configure
}

src_compile() {
	netsurf_make

	use doc && emake docs
}

src_test() {
	netsurf_make test
}

src_install() {
	netsurf_make DESTDIR="${D}" PREFIX=/usr install

	dodoc README docs/{Architecture,Macros,Todo,Treebuilder,Updated}
	use doc && dohtml build/docs/html/*
}
