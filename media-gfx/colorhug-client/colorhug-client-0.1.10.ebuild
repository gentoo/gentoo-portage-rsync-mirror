# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/colorhug-client/colorhug-client-0.1.10.ebuild,v 1.1 2012/06/11 21:25:59 gregkh Exp $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Client tools for the ColorHug display colorimeter"
HOMEPAGE="http://www.hughsie.com/"
SRC_URI="http://people.freedesktop.org/~hughsient/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-db/sqlite:3
		>=dev-libs/glib-2.28.0
		dev-libs/libgusb
		media-libs/lcms:2
		net-libs/libsoup:2.4
		x11-libs/gtk+:3
		>=x11-misc/colord-0.1.20"
RDEPEND="${DEPEND}"

pkg_postinst() {
	gnome2_schemas_update
}
pkg_postrm() {
	gnome2_schemas_update
}
