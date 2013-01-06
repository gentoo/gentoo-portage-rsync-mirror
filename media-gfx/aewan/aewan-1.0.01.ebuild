# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aewan/aewan-1.0.01.ebuild,v 1.2 2010/01/18 09:49:42 pva Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A curses-based ascii-art editor"
HOMEPAGE="http://aewan.sourceforge.net/"
SRC_URI="mirror://sourceforge/aewan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib
		>=sys-libs/ncurses-5.0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-debug_aewl-warnings.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc CHANGELOG README TODO || die
}
