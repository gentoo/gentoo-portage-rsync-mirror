# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbgrab/fbgrab-1.0-r1.ebuild,v 1.1 2013/03/21 21:27:08 hwoarang Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Framebuffer screenshot utility"
HOMEPAGE="http://hem.bredband.net/gmogmo/fbgrab/"
SRC_URI="http://hem.bredband.net/gmogmo/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/libpng
	 sys-libs/zlib"

DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e "s/gcc/\$(CC)/" \
		-e "s/-g//" \
		-e "s/splint/#splint/" \
		-e "s/-Wall/-Wall ${CPPFLAGS} ${CFLAGS} ${LDFLAGS}/" \
		Makefile || die "sed failed"

		epatch "${FILESDIR}/${P}-zlib_h.patch"
		epatch_user
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin ${PN}
	newman ${PN}.1.man ${PN}.1
}
