# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.1.1.ebuild,v 1.1 2013/01/14 07:21:57 jlec Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Draw any kind of boxes around your text"
HOMEPAGE="http://boxes.thomasjensen.com/"
SRC_URI="http://boxes.thomasjensen.com/download/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin src/boxes
	doman doc/boxes.1
	dodoc README
	insinto /usr/share/boxes
	doins boxes-config
}
