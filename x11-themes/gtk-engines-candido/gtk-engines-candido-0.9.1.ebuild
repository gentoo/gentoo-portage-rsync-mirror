# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-candido/gtk-engines-candido-0.9.1.ebuild,v 1.7 2012/05/05 04:10:05 jdhore Exp $

EAPI=4
inherit autotools eutils

MY_P=candido-engine-${PV}

DESCRIPTION="Candido GTK+ 2.x Theme Engine"
HOMEPAGE="http://candido.berlios.de/"
SRC_URI="mirror://berlios/candido/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog CREDITS NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glib-2.31.patch
	eautoreconf # required for interix
}

src_configure() {
	econf --enable-animation
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
