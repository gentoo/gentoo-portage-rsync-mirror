# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-weatherwallpapers/kdeartwork-weatherwallpapers-4.9.3.ebuild,v 1.4 2012/11/30 15:36:25 ago Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="WeatherWallpapers"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Weather aware wallpapers. Changes with weather outside."
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kdeartwork-wallpapers)
"
