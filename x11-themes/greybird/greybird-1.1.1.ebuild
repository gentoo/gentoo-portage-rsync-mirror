# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/greybird/greybird-1.1.1.ebuild,v 1.1 2013/05/04 07:32:19 ssuominen Exp $

EAPI=5

MY_PN=${PN/g/G}

DESCRIPTION="The default theme from Xubuntu"
HOMEPAGE="http://shimmerproject.org/project/greybird/ http://github.com/shimmerproject/Greybird"
SRC_URI="http://github.com/shimmerproject/${MY_PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-3.0 || ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="ayatana gnome"

RDEPEND=">=x11-themes/gtk-engines-murrine-0.90
	>=x11-themes/gtk-engines-unico-1.0.2"
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

	use ayatana || rm -rf unity
	use gnome || rm -rf metacity-1

	insinto /usr/share/themes/${MY_PN}
	doins -r *
}
