# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-2.45.ebuild,v 1.2 2014/11/05 13:05:51 voyageur Exp $

EAPI=5
inherit autotools

DESCRIPTION="A dockable app to report APM, ACPI, or SPIC battery status"
HOMEPAGE="http://windowmaker.org/dockapps/?name=wmbattery"
# Grab from http://windowmaker.org/dockapps/?download=${P}.tar.gz
SRC_URI="http://dev.gentoo.org/~voyageur/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE="upower"

RDEPEND="sys-apps/apmd
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	upower? ( || ( >=sys-power/upower-0.9.23 sys-power/upower-pm-utils ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/dockapps

DOCS=( ChangeLog README TODO )

src_prepare() {
	sed -i \
		-e '/^icondir/s:icons:pixmaps:' \
		autoconf/makeinfo.in || die

	use upower || { sed -i -e 's:USE_UPOWER = 1:#&:' autoconf/makeinfo.in || die; }

	eautoreconf
}
