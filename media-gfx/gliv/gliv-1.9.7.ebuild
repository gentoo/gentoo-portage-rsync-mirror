# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.9.7.ebuild,v 1.3 2014/08/09 12:09:43 ago Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="An image viewer that uses OpenGL"
HOMEPAGE="http://guichaz.free.fr/gliv/"
SRC_URI="http://guichaz.free.fr/gliv/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.6:2
	virtual/opengl
	>x11-libs/gtkglext-1.0.6"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/bison-1.875
	nls? ( sys-devel/gettext )"

src_prepare() {
	 epatch "${FILESDIR}"/${P}-as-needed.patch \
	 	"${FILESDIR}/${P}-destdir.patch"
	 eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}
