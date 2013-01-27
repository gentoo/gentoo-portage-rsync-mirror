# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wcd/wcd-5.2.3.ebuild,v 1.3 2013/01/27 14:37:42 jlec Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Wherever Change Directory"
HOMEPAGE="http://www.xs4all.nl/~waterlan/#WCD_ANCHOR"
SRC_URI="http://www.xs4all.nl/~waterlan/${P}-src.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="nls unicode"

CDEPEND="sys-libs/ncurses[unicode?]"
DEPEND="${CDEPEND}
	app-text/ghostscript-gpl"
RDEPEND="${CDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	tc-export CC
}

src_compile() {
	local mycompile="LFS=1"
	use nls || mycompile="${mycompile} ENABLE_NLS="
	use unicode && mycompile="${mycompile} UCS=1"
	emake \
		${mycompile}
}
