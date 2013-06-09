# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/higan-purify/higan-purify-03.ebuild,v 1.1 2013/06/09 19:18:31 hasufell Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

MY_P=purify_v${PV}-source

DESCRIPTION="Rom purifier for higan"
HOMEPAGE="http://byuu.org/higan/"
SRC_URI="http://higan.googlecode.com/files/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

RDEPEND="
	dev-games/higan-ananke
	!qt4? ( x11-libs/gtk+:2 )
	qt4? ( >=dev-qt/qtgui-4.5:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}/purify

src_prepare() {
	epatch "${FILESDIR}"/${P}-QA.patch
	sed -i \
		-e "/handle/s#/usr/local/lib#/usr/$(get_libdir)#" \
		nall/dl.hpp || die

	# regenerate .moc if needed
	if use qt4; then
		cd phoenix/qt || die
		moc -i -I. -o platform.moc platform.moc.hpp || die
	fi
}

src_compile() {
	if use qt4; then
		mytoolkit="qt"
	else
		mytoolkit="gtk"
	fi

	emake \
		platform="x" \
		compiler="$(tc-getCXX)" \
		phoenix="${mytoolkit}"
}

src_install() {
	dobin purify
}
