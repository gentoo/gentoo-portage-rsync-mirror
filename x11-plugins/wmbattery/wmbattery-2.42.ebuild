# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-2.42.ebuild,v 1.4 2014/05/26 19:57:06 ssuominen Exp $

EAPI=5
inherit autotools

DESCRIPTION="A dockable app to report APM, ACPI, or SPIC battery status"
HOMEPAGE="http://joeyh.name/code/wmbattery/"
SRC_URI="mirror://debian/pool/main/w/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE=""

#TODO FIXME: Does this release work with >=sys-power/upower-0.99 API?
#If not, adjust dependencies accordingly to:
#|| ( <sys-power/upower-0.99 sys-power/upower-pm-utils )
RDEPEND="sys-apps/apmd
	|| ( sys-power/upower sys-power/upower-pm-utils )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

DOCS=( README TODO )

src_prepare() {
	sed -i \
		-e '/^icondir/s:icons:pixmaps:' \
		autoconf/makeinfo.in || die

	eautoconf
}
