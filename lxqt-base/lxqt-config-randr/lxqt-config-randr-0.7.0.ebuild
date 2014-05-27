# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-config-randr/lxqt-config-randr-0.7.0.ebuild,v 1.1 2014/05/27 15:04:52 jauhien Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="LXQt monitor configuration"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

CDEPEND="dev-libs/glib:2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	x11-libs/libX11
	x11-libs/libXrandr"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	x11-apps/xrandr"
