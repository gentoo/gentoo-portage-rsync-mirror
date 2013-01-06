# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/echievements/echievements-2.ebuild,v 1.3 2012/12/29 10:15:22 tommy Exp $

EAPI=5

inherit enlightenment

DESCRIPTION="Show enlightenment echievements"

SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"
LICENSE="BSD-2"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-games/etrophy-0.5.1
	dev-libs/e_dbus
	dev-libs/eet
	media-libs/edje
	x11-wm/enlightenment:0.17="
DEPEND="${RDEPEND}
	virtual/pkgconfig"
