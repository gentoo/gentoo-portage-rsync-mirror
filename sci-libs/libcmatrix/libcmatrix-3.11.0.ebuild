# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libcmatrix/libcmatrix-3.11.0.ebuild,v 1.6 2012/12/27 18:55:33 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

MY_P="${PN}${PV}_lite"

DESCRIPTION="lite version of pNMRsim"
HOMEPAGE="http://www.dur.ac.uk/paul.hodgkinson/pNMRsim/"
#SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="sse threads"

RDEPEND="sci-libs/minuit"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}R3

PATCHES=(
	"${FILESDIR}"/${PV}-shared.patch
	"${FILESDIR}"/3.2.1-minuit2.patch
	"${FILESDIR}"/3.2.1-gcc4.4.patch
	"${FILESDIR}"/3.2.1-gcc4.6.patch
	"${FILESDIR}"/3.2.1-gcc4.7.patch
	"${FILESDIR}"/3.9.0-atlas.patch
	)

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	econf \
		--with-minuit \
		--without-atlas \
		--with-sysroot="${EROOT}" \
		$(use_with sse) \
		$(use_with threads)
}

src_install() {
	dolib.so lib/*.so*

	insinto /usr/include/${PN}R3
	doins include/*

	dodoc CHANGES docs/*
}
