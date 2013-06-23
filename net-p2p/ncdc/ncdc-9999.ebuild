# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ncdc/ncdc-9999.ebuild,v 1.11 2013/06/23 21:32:33 xmw Exp $

EAPI=5

inherit autotools git-2 toolchain-funcs

DESCRIPTION="ncurses directconnect client"
HOMEPAGE="http://dev.yorhel.nl/ncdc"
EGIT_REPO_URI="git://g.blicky.net/ncdc.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-arch/bzip2
	dev-db/sqlite:3
	dev-libs/glib:2
	net-libs/gnutls
	sys-libs/ncurses:5[unicode]
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/makeheaders
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-git-version
}

src_compile() {
	emake AR="$(tc-getAR)"
}
