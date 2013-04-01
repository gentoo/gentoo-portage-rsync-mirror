# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/angelscript/angelscript-2.26.2.ebuild,v 1.1 2013/04/01 12:57:50 hasufell Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="A flexible, cross-platform scripting library"
HOMEPAGE="http://www.angelcode.com/angelscript/"
SRC_URI="http://www.angelcode.com/angelscript/sdk/files/angelscript_${PV}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND="app-arch/unzip"

S=${WORKDIR}/sdk/${PN}/projects/gnuc
S2=${WORKDIR}/${P}_static

src_prepare() {
	if use static-libs ; then
		cp -a "${WORKDIR}"/sdk "${S2}"/ || die
	fi
}

src_compile() {
	tc-export CXX AR RANLIB

	emake SHARED=1 VERSION=${PV}

	if use static-libs ; then
		cd "${S2}"/${PN}/projects/gnuc || die
		emake
	fi
}

src_install() {
	doheader "${WORKDIR}"/sdk/${PN}/include/angelscript.h
	dolib.so "${WORKDIR}"/sdk/${PN}/lib/libangelscript-${PV}.so
	dosym libangelscript-${PV}.so /usr/$(get_libdir)/libangelscript.so

	if use static-libs ; then
		 dolib.a "${S2}"/${PN}/lib/libangelscript.a
	fi

	use doc && dohtml -r "${WORKDIR}"/sdk/docs/*
}
