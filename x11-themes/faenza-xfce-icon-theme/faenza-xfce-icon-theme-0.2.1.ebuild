# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/faenza-xfce-icon-theme/faenza-xfce-icon-theme-0.2.1.ebuild,v 1.1 2012/01/10 18:43:06 ssuominen Exp $

EAPI=4
inherit gnome2-utils

MY_PN=Faenza-Xfce

DESCRIPTION="A set of extra icons to complete the Faenza icon theme for the Xfce desktop environment"
HOMEPAGE="http://github.com/shimmerproject/Faenza-Xfce"
SRC_URI="http://github.com/shimmerproject/${MY_PN}/tarball/v.${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-themes/faenza-icon-theme"
DEPEND=""

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_install() {
	insinto /usr/share/icons/${MY_PN}
	doins -r index.theme apps
	dodoc README
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
