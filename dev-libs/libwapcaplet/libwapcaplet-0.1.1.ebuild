# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwapcaplet/libwapcaplet-0.1.1.ebuild,v 1.7 2013/02/27 08:21:27 xmw Exp $

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="string internment library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libwapcaplet/"
SRC_URI="http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="static-libs test"

RDEPEND=""
DEPEND="virtual/pkgconfig
	test? ( dev-libs/check )"

src_prepare() {
	sed -e "/^CCOPT :=/s:=.*:=:" \
		-i build/makefiles/Makefile.{gcc,clang} || die
	sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
		-i Makefile || die
	sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
		-i ${PN}.pc.in || die

	echo "Q  := " >> Makefile.config
	echo "CC := $(tc-getCC)" >> Makefile.config
	echo "AR := $(tc-getAR)" >> Makefile.config
}

src_compile() {
	emake COMPONENT_TYPE=lib-shared
	use static-libs && emake COMPONENT_TYPE=lib-static
}

src_test() {
	emake COMPONENT_TYPE=lib-shared test
	use static-libs && emake COMPONENT_TYPE=lib-static test
}

src_install() {
	emake COMPONENT_TYPE=lib-shared DESTDIR="${D}" PREFIX=/usr install
	use static-libs && \
		emake COMPONENT_TYPE=lib-static DESTDIR="${D}" PREFIX=/usr install
	dodoc README
}
