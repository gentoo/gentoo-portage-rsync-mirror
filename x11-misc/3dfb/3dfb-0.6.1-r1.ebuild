# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3dfb/3dfb-0.6.1-r1.ebuild,v 1.2 2014/03/13 09:04:35 pinkbyte Exp $

EAPI=5

inherit eutils

DESCRIPTION="3D File Browser"
HOMEPAGE="http://sourceforge.net/projects/dz3d/"
SRC_URI="mirror://sourceforge/dz3d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="dev-libs/glib:2
	media-libs/freeglut
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README WISHLIST )

src_prepare() {
	epatch "${FILESDIR}/${PV}-gcc41.patch" \
		"${FILESDIR}/${P}-freeglut-compat.patch"
	epatch_user
}
