# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-wallpapers/kde-wallpapers-4.9.5.ebuild,v 1.5 2013/02/07 01:06:19 naota Exp $

EAPI=4

KMNAME="kde-wallpapers"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="KDE wallpapers"
KEYWORDS="amd64 ~arm ppc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

add_blocker kdebase-wallpapers

src_configure() {
	mycmakeargs=( -DWALLPAPER_INSTALL_DIR="${EPREFIX}/usr/share/wallpapers" )

	kde4-base_src_configure
}
