# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.14.1-r1.ebuild,v 1.6 2013/01/05 17:33:08 ago Exp $

EAPI=4
inherit base autotools games-ggz

DESCRIPTION="The client libraries for GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ppc ppc64 ~sh sparc ~x86 ~amd64-linux ~x86-linux"

IUSE="debug static-libs"

RDEPEND="~dev-games/libggz-${PV}
	dev-libs/expat
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

PATCHES=( "${FILESDIR}"/${P}-destdir.patch
	"${FILESDIR}"/${P}-linguas.patch )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	games-ggz_src_configure \
		$(use_enable static-libs static)
}

src_install() {
	games-ggz_src_install
	find "${ED}" -name '*.la' -exec rm -f {} +
}
