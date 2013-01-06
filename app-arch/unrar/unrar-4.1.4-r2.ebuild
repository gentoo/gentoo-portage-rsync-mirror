# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-4.1.4-r2.ebuild,v 1.10 2012/03/19 19:00:17 armin76 Exp $

EAPI=4
inherit flag-o-matic multilib toolchain-funcs

MY_PN=${PN}src

DESCRIPTION="Uncompress rar files"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"
SRC_URI="http://www.rarlab.com/rar/${MY_PN}-${PV}.tar.gz"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="!<=app-arch/unrar-gpl-0.0.1_p20080417"

S=${WORKDIR}/unrar

src_prepare() {
	sed -i \
		-e "/libunrar/s:.so:$(get_libname ${PV%.*.*}):" \
		-e "s:-shared:& -Wl,-soname -Wl,libunrar$(get_libname ${PV%.*.*}):" \
		makefile.unix || die
}

src_compile() {
	local f=makefile.unix

	emake -f ${f} CXX="$(tc-getCXX)" CXXFLAGS="-fPIC ${CXXFLAGS}" lib
	ln -s libunrar$(get_libname ${PV%.*.*}) libunrar$(get_libname)
	ln -s libunrar$(get_libname ${PV%.*.*}) libunrar$(get_libname ${PV})

	emake -f ${f} clean

	emake -f ${f} CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" STRIP="true"
}

src_install() {
	dobin unrar
	dodoc readme.txt

	dolib.so libunrar*

	insinto /usr/include/libunrar${PV%.*.*}
	doins *.hpp
	dosym libunrar${PV%.*.*} /usr/include/libunrar
}
