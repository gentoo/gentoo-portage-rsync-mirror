# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcoincoin/wmcoincoin-2.6.1.ebuild,v 1.1 2012/08/21 08:43:21 voyageur Exp $

EAPI=4

DESCRIPTION="a dockapp for browsing dacode news and board sites."
HOMEPAGE="http://hules.free.fr/wmcoincoin"
SRC_URI="http://hules.free.fr/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls xinerama"

RDEPEND="x11-libs/gtk+:2
	media-libs/imlib2
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libX11
	x11-libs/libXft
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-libs/libXt
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

src_configure() {
	econf $(use_enable nls) $(use_enable xinerama)
}

src_install () {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
