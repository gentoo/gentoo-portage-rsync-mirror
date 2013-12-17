# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbgrab/fbgrab-1.2.ebuild,v 1.1 2013/12/17 19:06:56 zlogene Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Framebuffer screenshot utility"
HOMEPAGE="http://fbgrab.monells.se/"
SRC_URI="http://fbgrab.monells.se/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/libpng:=
	 sys-libs/zlib"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e "s:-g::" Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin ${PN}
	newman ${PN}.1.man ${PN}.1
}
