# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/muscle/muscle-3.8.31.ebuild,v 1.1 2010/06/24 19:03:18 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

MY_P="${PN}${PV}_src"

DESCRIPTION="Multiple sequence comparison by log-expectation"
HOMEPAGE="http://www.drive5.com/muscle/"
SRC_URI="http://www.drive5.com/muscle/downloads${PV}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="!sci-libs/libmuscle"
DEPEND=""

S="${WORKDIR}"/${PN}${PV}/src

src_prepare() {
	epatch "${FILESDIR}"/${PV}-make.patch
	tc-export CXX
}

src_install() {
	dobin "${PN}" || die
	dodoc *.txt || die
}
