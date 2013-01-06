# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/greybird/greybird-0.8.2.ebuild,v 1.2 2012/08/04 06:39:06 ssuominen Exp $

EAPI=4

MY_PN=${PN/g/G}

DESCRIPTION="The default Xubuntu 11.04 theme (emerald, GTK+-2, GTK+-3, metacity, xfwm4 and xfce4-notifyd)"
HOMEPAGE="http://shimmerproject.org/project/greybird/ http://github.com/shimmerproject/Greybird"
SRC_URI="http://github.com/shimmerproject/${MY_PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0 || ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=x11-themes/gtk-engines-murrine-0.90
	>=x11-themes/gtk-engines-unico-1.0.1"
DEPEND=""

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_install() {
	dodoc README
	rm -f README LICENSE*

	insinto /usr/share/themes/${MY_PN}_compact/xfwm4
	doins xfwm4_compact/*
	rm -rf xfwm4_compact

	insinto /usr/share/themes/${MY_PN}
	doins -r *
}
