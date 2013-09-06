# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wcd/wcd-5.2.4.ebuild,v 1.1 2013/09/06 11:15:29 polynomial-c Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Wherever Change Directory"
HOMEPAGE="http://www.xs4all.nl/~waterlan/#WCD_ANCHOR"
SRC_URI="http://www.xs4all.nl/~waterlan/${P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="nls unicode"

CDEPEND="
	sys-libs/ncurses[unicode?]
	unicode? ( dev-libs/libunistring )"
DEPEND="${CDEPEND}
	app-text/ghostscript-gpl"
RDEPEND="${CDEPEND}"

S="${WORKDIR}"/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	tc-export CC
}

src_compile() {
	local mycompile="LFS=1"
	use nls || mycompile="${mycompile} ENABLE_NLS="
	use unicode && mycompile="${mycompile} UCS=1 UNINORM=1"
	emake \
		${mycompile}
}

src_install() {
	local DOCS="../README.txt"
	default
	emake DESTDIR="${D}" DOTWCD=1 install-profile sysconfdir="/etc"
}
