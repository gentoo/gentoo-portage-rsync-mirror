# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/light-themes/light-themes-0.1.8.29.ebuild,v 1.3 2012/04/29 16:22:50 maekke Exp $

EAPI="3"

DESCRIPTION="GTK2/GTK3 Ambiance and Radiance themes from Ubuntu"
HOMEPAGE="https://launchpad.net/light-themes"
SRC_URI="mirror://ubuntu/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk3"

DEPEND=""
RDEPEND="x11-themes/gtk-engines-murrine
	gtk3? ( x11-themes/gtk-engines-unico )"

src_install() {
	insinto /usr/share/themes
	doins -r Radiance Ambiance || die
}
