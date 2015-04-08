# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/muscle/muscle-3.7-r1.ebuild,v 1.5 2010/07/20 11:54:30 josejx Exp $

EAPI="3"

inherit eutils toolchain-funcs

MY_P="${PN}${PV}_src"
DESCRIPTION="Multiple sequence comparison by log-expectation"
HOMEPAGE="http://www.drive5.com/muscle/"
SRC_URI="http://www.drive5.com/muscle/downloads${PV}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="!sci-libs/libmuscle"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	edos2unix progress.cpp globalslinux.cpp
	epatch "${FILESDIR}"/${PV}-bufferoverflow.patch
	sed -i \
		"s:-static::g" \
		"${S}/Makefile"
	sed -i \
		"/strip/d" \
		"${S}/Makefile"
}

src_compile() {
	emake \
		GPP="$(tc-getCXX)" \
		CFLAGS="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin muscle || die
}
