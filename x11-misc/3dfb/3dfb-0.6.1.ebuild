# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3dfb/3dfb-0.6.1.ebuild,v 1.9 2012/05/05 04:53:46 jdhore Exp $

inherit eutils

DESCRIPTION="3D File Browser"
HOMEPAGE="http://sourceforge.net/projects/dz3d/"
SRC_URI="mirror://sourceforge/dz3d/${P}.tar.gz"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	media-libs/freeglut
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/0.6.1-gcc41.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README WISHLIST
}
