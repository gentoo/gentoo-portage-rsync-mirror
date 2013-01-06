# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-mmkeys/gmpc-mmkeys-11.8.16.ebuild,v 1.4 2012/05/05 08:27:17 jdhore Exp $

EAPI=4

DESCRIPTION="Bind multimedia keys via gnome settings daemon"
HOMEPAGE="http://gmpc.wikia.com/wiki/Plugins"
SRC_URI="http://download.sarine.nl/Programs/gmpc/11.8/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	>=media-sound/gmpc-${PV}"
DEPEND="${RDEPEND}
	dev-lang/vala:0.10
	virtual/pkgconfig"

src_configure() {
	VALAC=$(type -p valac-0.10) \
		econf --disable-static
}

src_install() {
	default
	find "${ED}" -name "*.la" -exec rm {} + || die
}
