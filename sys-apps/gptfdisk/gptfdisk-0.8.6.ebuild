# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gptfdisk/gptfdisk-0.8.6.ebuild,v 1.6 2013/05/05 17:28:43 ago Exp $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="GPT partition table manipulator for Linux"
HOMEPAGE="http://www.rodsbooks.com/gdisk/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~ia64 ~mips ppc ~ppc64 ~sparc x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="kernel_linux +icu"

RDEPEND="
	dev-libs/popt
	>=sys-libs/ncurses-5.7-r7
	icu? ( dev-libs/icu:= )
	kernel_linux? ( sys-apps/util-linux )" # libuuid
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	if use icu; then
		append-cxxflags $($(tc-getPKG_CONFIG) --variable=CXXFLAGS icu-io icu-uc)
	else
		sed \
			-e 's:-licuio::g' \
			-e 's:-licuuc::g' \
			-e 's:-D USE_UTF16::g' \
			-i Makefile || die
	fi

	sed \
		-e '/g++/s:=:?=:g' \
		-e "s:-lncurses:$($(tc-getPKG_CONFIG) --libs ncurses):g" \
		-i Makefile || die

	tc-export CXX
}

src_install() {
	dosbin gdisk sgdisk cgdisk fixparts
	doman *.8
	dodoc NEWS README
}
