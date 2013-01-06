# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/anyremote/anyremote-6.2.ebuild,v 1.1 2012/12/18 19:00:04 hwoarang Exp $

EAPI="5"

DESCRIPTION="Anyremote provides wireless bluetooth, infrared or cable remote control service"
HOMEPAGE="http://anyremote.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth dbus"

RDEPEND="bluetooth? ( net-wireless/bluez )
	dbus? ( sys-apps/dbus )
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=(AUTHORS ChangeLog NEWS README)
src_configure() {
	econf --docdir="/usr/share/doc/${PF}/" $(use_enable bluetooth) $(use_enable dbus)
}
