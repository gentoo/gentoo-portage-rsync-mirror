# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/light-themes/light-themes-0.1.8.29.ebuild,v 1.4 2013/02/07 23:00:31 ulm Exp $

EAPI="3"

DESCRIPTION="GTK2/GTK3 Ambiance and Radiance themes from Ubuntu"
HOMEPAGE="https://launchpad.net/light-themes"
SRC_URI="mirror://ubuntu/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CC-BY-SA-3.0"
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
