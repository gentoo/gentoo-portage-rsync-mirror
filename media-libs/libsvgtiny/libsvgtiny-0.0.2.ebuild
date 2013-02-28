# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsvgtiny/libsvgtiny-0.0.2.ebuild,v 1.2 2013/02/28 07:50:00 xmw Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libsvgtiny/"
SRC_URI="http://download.netsurf-browser.org/netsurf/releases/source-full/netsurf-2.9-full-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="debug static-libs"

RDEPEND=""
DEPEND="dev-util/gperf
	virtual/pkgconfig"

pkg_setup(){
	netsurf_src_prepare() {
		sed -e "/^CCOPT :=/s:=.*:=:" \
			-e "/^CCNOOPT :=/s:=.*:=:" \
			-e "/^CCDBG :=/s:=.*:=:" \
			-i build/makefiles/Makefile.{gcc,clang}
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
src_unpack() {
	default
	mv netsurf-2.9/${P} . || die
	rm -r netsurf-2.9 || die
}

src_prepare() {
	netsurf_src_prepare
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
