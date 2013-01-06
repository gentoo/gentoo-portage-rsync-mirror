# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cfe/cfe-0.12.ebuild,v 1.6 2012/11/09 22:14:57 ago Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="Console font editor"
# the homepage is missing, so if you find new location please let us know
HOMEPAGE="http://lrn.ru/~osgene/"
SRC_URI="http://download.uhulinux.hu/pub/pub/mirror/http:/lrn.ru/~osgene/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch

	# Remove unconditional assignment of CFLAGS
	sed -i -e '/GCC = yes/d' configure.in || die
	eautoreconf
}

src_install() {
	dobin cfe
	doman cfe.1
	dodoc ChangeLog INSTALL THANKS dummy.fnt
}
