# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skalibs/skalibs-1.6.0.0.ebuild,v 1.1 2014/11/04 03:41:36 williamh Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="development files used for building software at skarnet.org: essentially general-purpose libraries"
HOMEPAGE="http://www.skarnet.org/software/skalibs/index.html"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/prog/${P}

src_configure() {
	echo $(tc-getCC) ${CFLAGS} > conf-compile/conf-cc
	echo /usr/bin:/bin > conf-compile/conf-defaultpath
	echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-dynld
	echo /usr/$(get_libdir)/${PN} > conf-compile/conf-install-library
	echo /$(get_libdir)/${PN} > conf-compile/conf-install-library.so
	echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-ld
	rm conf-compile/flag-slashpackage
	echo > conf-compile/stripbins
	echo > conf-compile/striplibs
}

src_compile() {
	emake -j1
}

src_install() {
	insinto /etc
	doins etc/leapsecs.dat

	insinto /usr/include/${PN}
	doins include/*

	insopts -m0755
	insinto /$(get_libdir)/${PN}
	doins library.so/*
	insopts -m0644
	if use static-libs ; then
	insinto /usr/$(get_libdir)/${PN}
		doins library/*
	fi

	dodir /etc/ld.so.conf.d/
	echo "/$(get_libdir)/${PN}" > ${ED}/etc/ld.so.conf.d/10${PN}.conf || die

	insinto /usr/lib/${PN}
doins -r sysdeps

	dodoc $(find doc -type f ! -name "*.html" ! -name "COPYING")
	use doc && dohtml -r doc/*
}
