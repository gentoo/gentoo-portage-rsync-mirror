# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist-datahub/zeitgeist-datahub-0.8.2.ebuild,v 1.3 2012/05/05 06:25:19 jdhore Exp $

EAPI=4

inherit autotools-utils versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Provides passive plugins to insert events into zeitgeist"
HOMEPAGE="http://launchpad.net/zeitgeist-datahub"
SRC_URI="http://launchpad.net/zeitgeist-datahub/${MY_PV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="download"

CDEPEND="
	dev-libs/libzeitgeist
	dev-libs/glib:2
	x11-libs/gtk+:2
	dev-lang/vala:0.12"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
PDEPEND="gnome-extra/zeitgeist"

src_configure() {
	local myeconfargs=(
		$(use_enable download downloads-monitor)
		VALAC=$(type -P valac-0.12)
	)
	autotools-utils_src_configure
}
